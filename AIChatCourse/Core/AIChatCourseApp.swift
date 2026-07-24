//
//  AIChatCourseApp.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import Firebase
import SwiftUI

@main
struct AIChatCourseApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.dependencies.authManager)
                .environment(delegate.dependencies.userManager)
                .environment(delegate.dependencies.aiManager)
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        dependencies = Dependencies()

        return true
    }
}

@MainActor
struct Dependencies {
    let authManager: AuthManager
    let userManager: UserManager
    let aiManager: AIManager

    init() {
        authManager = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(userServices: ProductionUserServices())
        aiManager = AIManager(service: OpenAIService())
    }
}
