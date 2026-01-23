//
//  UserManager.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/23/26.
//

import SwiftUI

import FirebaseFirestore

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
}

struct FirebaseUserService: UserService {
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }

    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }
}

@MainActor
@Observable
final class UserManager {

    private let service: UserService
    private(set) var currentUser: UserModel?

    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }

    func logIn(userAuthInfo: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(userAuthInfo: userAuthInfo, creationVersion: creationVersion)

        try await service.saveUser(user: user)
    }
}
