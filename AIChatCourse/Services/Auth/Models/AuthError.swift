//
//  AuthError.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/23/26.
//

import Foundation

enum AuthError: LocalizedError {
    case userNotFound
    case notSignedIn

    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "Current authenticated user not found."
        case .notSignedIn:
            return "User is not signed in."
        }
    }
}
