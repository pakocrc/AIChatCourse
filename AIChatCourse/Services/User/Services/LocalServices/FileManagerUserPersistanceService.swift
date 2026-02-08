//
//  FileManagerUserPersistanceService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 2/8/26.
//

import Foundation

struct FileManagerUserPersistanceService: LocalUserPersistanceService {
    private let userDocumentKey = "current_user"

    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }

    func saveCurrentUser(user: UserModel) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}

struct MockLocalUserPersistanceService: LocalUserPersistanceService {
    let currentUser: UserModel?

    init(currentUser: UserModel? = nil) {
        self.currentUser = currentUser
    }

    func getCurrentUser() -> UserModel? {
        currentUser
    }

    func saveCurrentUser(user: UserModel) throws {

    }
}
