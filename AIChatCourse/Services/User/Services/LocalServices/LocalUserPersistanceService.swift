//
//  LocalUserPersistanceService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 2/8/26.
//

protocol LocalUserPersistanceService {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel) throws
}
