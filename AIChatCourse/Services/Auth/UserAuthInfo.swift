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
}
