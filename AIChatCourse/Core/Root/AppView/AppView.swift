//
//  AppView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct AppView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @State var appState: AppState = .init()

    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabBarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            })
        .task {
            await checkAuthStatus()
        }
        .onChange(of: appState.showTabBar, { _, showTabBar in
            if !showTabBar {
                Task {
                    await checkAuthStatus()
                }
            }
        })
        .environment(appState)
        .environment(authManager)
    }

    private func checkAuthStatus() async {
        if let user = authManager.userAuth {
            // User is authenticated
            print("[\(Bundle.main.appName)] [AppView] [checkAuthStatus] User is authenticated: \(user.uid)")

            do {
                try await userManager.logIn(userAuthInfo: user, isNewUser: false)

            } catch {
                // Failed to store in the DB
                print("[\(Bundle.main.appName)] [AppView] [checkAuthStatus] Error saving user to the database: \(error)")

                try? await Task.sleep(for: .seconds(3))
                await checkAuthStatus()
            }

        } else {
            // User is not authenticated
            do {
                // Sign in anonymously
                let result = try await authManager.signInAnonymously()
                print("[\(Bundle.main.appName)] [AppView] [checkAuthStatus] Sign In Anonymous successful: \(result)")

                try await userManager.logIn(userAuthInfo: result.user, isNewUser: result.isNewUser)

            } catch {
                print("[\(Bundle.main.appName)] [AppView] [checkAuthStatus] Error signing in anonymously: \(error)")
                try? await Task.sleep(for: .seconds(3))
                await checkAuthStatus()
            }
        }
    }
}

#Preview("AppView - Tab Bar") {
    AppView(appState: AppState(showTabBar: true))
        .environment(AuthManager(service: MockAuthService(currentUser: UserAuthInfo.mock())))
        .environment(UserManager(userServices: MockUserServices(user: .mock)))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
        .environment(AuthManager(service: MockAuthService(currentUser: nil)))
        .environment(UserManager(userServices: MockUserServices()))
}
