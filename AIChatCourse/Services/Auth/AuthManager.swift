//
//  AuthManager.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/23/26.
//

import SwiftUI

@MainActor
@Observable
final class AuthManager {

    private let service: AuthService
    private(set) var userAuth: UserAuthInfo?
    private var listener: (any NSObjectProtocol)?

    init(service: AuthService) {
        self.service = service
        self.userAuth = service.getAuthenticatedUser()
        self.addAuthListener()
    }

    private func addAuthListener() {
        Task {
            for await value in service.addAuthenticatedUserListener(onListenerAttached: { listener in
                self.listener = listener
            }) {
                self.userAuth = value
                print("[\(Bundle.main.appName)] [AuthManager] [addAuthListener] Auth listener updated: \(self.userAuth?.uid ?? "no uid")")
            }
        }
    }

    func getAuthId() throws -> String {
        guard let uid = userAuth?.uid else {
            throw AuthError.notSignedIn
        }
        return uid
    }

    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await service.signInAnonymously()
    }

    func signInWithApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        try await service.signInWithApple()
    }

    func signOut() throws {
        try service.signOut()
        userAuth = nil
    }

    func deleteAccount() async throws {
        try await service.deleteAccount()
        userAuth = nil
    }
}
