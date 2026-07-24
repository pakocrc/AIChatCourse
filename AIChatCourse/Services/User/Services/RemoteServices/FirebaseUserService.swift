//
//  FirebaseUserService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 2/8/26.
//

import FirebaseFirestore
import SwiftfulFirestore

typealias ListenerRegistration = FirebaseFirestore.ListenerRegistration

struct FirebaseUserService: RemoteUserService {
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

    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }

    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}

struct MockRemoteUserService: RemoteUserService {
    let currentUser: UserModel?

    init(currentUser: UserModel? = nil) {
        self.currentUser = currentUser
    }

    func saveUser(user: UserModel) async throws {

    }

    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {

    }

    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }

    func deleteUser(userId: String) async throws {

    }
}
