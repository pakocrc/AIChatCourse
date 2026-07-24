//
//  UserAuthInfo.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/20/26.
//

import Foundation

struct UserAuthInfo: Sendable {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let creationDate: Date?
    let lastSignInDate: Date?

    static func mock(isAnonymous: Bool = false) -> UserAuthInfo {
        UserAuthInfo(
            uid: isAnonymous ? UUID().uuidString : "testUser1234",
            email: "test@test.com",
            isAnonymous: isAnonymous,
            creationDate: .now,
            lastSignInDate: .now
        )
    }
}
