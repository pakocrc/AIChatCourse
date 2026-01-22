//
//  AppView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct AppView: View {
    @Environment(\.authService) private var authService
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
        .environment(\.authService, authService)
    }

    private func checkAuthStatus() async {
        if let user = authService.getAuthenticatedUser() {
            // User is authenticated
            print("User is authenticated: \(user.uid)")

        } else {
            // User is not authenticated
            do {
                // Sign in anonymously
                let result = try await authService.signInAnonymously()
                print("Sign In Anonymous successful: \(result)")

            } catch {
                print("Error signing in anonymously: \(error)")
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
