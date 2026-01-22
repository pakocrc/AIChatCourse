//
//  FirebaseAuthService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/20/26.
//

import FirebaseAuth
import SignInAppleAsync
import SwiftUI

extension EnvironmentValues {
    @Entry var authService: FirebaseAuthService = FirebaseAuthService()
}

struct FirebaseAuthService: AuthService {

    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser {
            return UserAuthInfo(user: user)
        }

        return nil
    }

    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        return result.asAuthInfo
    }

    func signInWithApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let helper = await SignInWithAppleHelper()
        let response = try await helper.signIn()

        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce)

        // Try to link to existing anonymous account.
        if let user = Auth.auth().currentUser, user.isAnonymous {

            do {
                let result = try await user.link(with: credential)
                return result.asAuthInfo

            } catch let error as NSError {
                print("Failed to link existing anonymous account: \(error)")

                let authError = AuthErrorCode(rawValue: error.code)
                switch authError {
                case .providerAlreadyLinked, .credentialAlreadyInUse:

                    if let secondaryCredential = error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                        let result = try await Auth.auth().signIn(with: secondaryCredential)
                        return result.asAuthInfo
                    }

                default:
                    break
                }
            }
        }

        let result = try await Auth.auth().signIn(with: credential)
        return result.asAuthInfo
    }

    func signOut() throws {
        try? Auth.auth().signOut()
    }

    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.delete()
    }

    enum AuthError: LocalizedError {
        case userNotFound

        var errorDescription: String? {
            switch self {
            case .userNotFound:
                return "Current authenticated user not found."
            }
        }

    }
}

extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
