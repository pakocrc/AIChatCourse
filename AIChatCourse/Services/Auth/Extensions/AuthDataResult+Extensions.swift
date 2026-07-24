//
//  AuthDataResult+Extensions.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/22/26.
//

import FirebaseAuth

extension AuthDataResult {
    var asAuthInfo: (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo(user: user)
        let isNewUser = additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
