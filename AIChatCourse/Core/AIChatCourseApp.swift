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
                .environment(delegate.authManager)
                .environment(delegate.userManager)
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    var authManager: AuthManager!
    var userManager: UserManager!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        authManager = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(userServices: ProductionUserServices())

        return true
    }
}
