//
//  MockAuthService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/22/26.
//

struct MockAuthService: AuthService {

    let currentUser: UserAuthInfo?

    func getAuthenticatedUser() -> UserAuthInfo? {
        self.currentUser
    }

    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user, true)
    }

    func signInWithApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: false)
        return (user, false)
    }

    func signOut() throws {

    }

    func deleteAccount() async throws {

    }
}
