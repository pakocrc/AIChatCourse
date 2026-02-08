//
//  UserManager.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/23/26.
//

import SwiftUI

@MainActor
@Observable
final class UserManager {

    private let remoteService: RemoteUserService
    private let localService: LocalUserPersistanceService

    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?

    init(userServices: UserServices) {
        self.remoteService = userServices.remoteService
        self.localService = userServices.localService
        self.currentUser = localService.getCurrentUser()
        // print("[\(Bundle.main.appName)] [UserManager] [init] Loaded current user on launch: \(currentUser?.userId ?? "nil") from \(NSHomeDirectory())")
    }

    func logIn(userAuthInfo: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(userAuthInfo: userAuthInfo, creationVersion: creationVersion)
        try await remoteService.saveUser(user: user)
        addCurrentUserListener(userId: userAuthInfo.uid)
    }

    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()

        Task {
            do {
                for try await value in remoteService.streamUser(userId: userId) {
                    self.currentUser = value
                    try self.saveCurrentUserLocally()
                    // print("[\(Bundle.main.appName)] [UserManager] [addCurrentUserListener] Successfully listened to user \(value.userId)")
                }
            } catch {
                print("[\(Bundle.main.appName)] [UserManager] [addCurrentUserListener] Error attaching user listener. Description: \(error)")
            }
        }
    }

    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }

    func deleteCurrentUser() async throws {
        let userId = try currentUserId()
        try await remoteService.deleteUser(userId: userId)
        signOut()
    }

    func markOnboardingComplete(profileColorHex: String) async throws {
        let userId = try currentUserId()
        try await remoteService.markOnboardingCompleted(userId: userId, profileColorHex: profileColorHex)
    }

    private func currentUserId() throws -> String {
        guard let uid = currentUser?.userId else {
            throw UserManagerError.noUserId
        }

        return uid
    }

    private func saveCurrentUserLocally() throws {
        Task {
            do {
                guard let currentUser = self.currentUser else { return }

                try localService.saveCurrentUser(user: currentUser)
                print("[\(Bundle.main.appName)] [UserManager] [saveCurrentUserLocally] Successfully saved current user locally.")

            } catch {
                print("[\(Bundle.main.appName)] [UserManager] [saveCurrentUserLocally] Error saving current user locally. Description: \(error)")
            }
        }
    }

    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
