//
//  AppView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct AppView: View {
    @Environment(AuthManager.self) private var authManager
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
            print("[AppView] User is authenticated: \(user.uid)")

        } else {
            // User is not authenticated
            do {
                // Sign in anonymously
                let result = try await authManager.signInAnonymously()
                print("[AppView] Sign In Anonymous successful: \(result)")

            } catch {
                print("[AppView] Error signing in anonymously: \(error)")
            }
        }
    }
}

#Preview("AppView - Tab Bar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
