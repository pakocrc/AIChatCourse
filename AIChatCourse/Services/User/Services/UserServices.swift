//
//  UserServices.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 2/8/26.
//

protocol UserServices {
    var remoteService: RemoteUserService { get }
    var localService: LocalUserPersistanceService { get }
}

struct ProductionUserServices: UserServices {
    var remoteService: RemoteUserService = FirebaseUserService()
    var localService: LocalUserPersistanceService = FileManagerUserPersistanceService()
}

struct MockUserServices: UserServices {
    var remoteService: RemoteUserService
    var localService: LocalUserPersistanceService

    init(user: UserModel? = nil) {
        self.remoteService = MockRemoteUserService(currentUser: user)
        self.localService = MockLocalUserPersistanceService(currentUser: user)
    }
}
