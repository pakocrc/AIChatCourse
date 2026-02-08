//
//  UserManager.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/23/26.
//

import SwiftUI

import FirebaseFirestore
import SwiftfulFirestore

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
    func deleteUser(userId: String) async throws
    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error>
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}

struct MockUserService: UserService {
    let currentUser: UserModel?

    func saveUser(user: UserModel) async throws {

    }

    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {

    }

    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }

    func deleteUser(userId: String) async throws {

    }
}

struct FirebaseUserService: UserService {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }

    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }

    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex,
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true
        ])
    }

    func streamUser(userId: String, onListenerConfigured: @escaping (ListenerRegistration) -> Void) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }

    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}

@MainActor
@Observable
final class UserManager {

    private let service: UserService
    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?

    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }

    func logIn(userAuthInfo: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(userAuthInfo: userAuthInfo, creationVersion: creationVersion)
        try await service.saveUser(user: user)
        addCurrentUserListener(userId: userAuthInfo.uid)
    }

    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()

        Task {
            do {
                for try await value in service.streamUser(userId: userId, onListenerConfigured: { [weak self] listener in
                    self?.currentUserListener = listener
                    print("[\(Bundle.main.appName)] [UserManager] [addCurrentUserListener] Successfully added listener")

                }) {
                    self.currentUser = value
                    print("[\(Bundle.main.appName)] [UserManager] [addCurrentUserListener] Successfully listened to user \(value.userId)")
                }
            } catch {
                print("[\(Bundle.main.appName)] [UserManager] [addCurrentUserListener] Error attaching user listener: \(error)")
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
        try await service.deleteUser(userId: userId)
        signOut()
    }

    func markOnboardingComplete(profileColorHex: String) async throws {
        let userId = try currentUserId()
        try await service.markOnboardingCompleted(userId: userId, profileColorHex: profileColorHex)
    }

    private func currentUserId() throws -> String {
        guard let uid = currentUser?.userId else {
            throw UserManagerError.noUserId
        }

        return uid
    }

    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
