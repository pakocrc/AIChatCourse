//
//  RemoteUserService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 2/8/26.
//

protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func deleteUser(userId: String) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}
