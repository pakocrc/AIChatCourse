//
//  UserModel.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 8/8/25.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
	let userId: String
	let didCompleteOnboarding: Bool?
	let profileColorHex: String?
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let lastSignInDate: Date?
    let creationVersion: String?

	var profileColorCalculated: Color {
		guard let profileColorHex else {
			return Color.accent
		}
		return Color(hex: profileColorHex)
	}

    init(
        userId: String,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil,
        email: String?,
        isAnonymous: Bool?,
        creationDate: Date?,
        lastSignInDate: Date?,
        creationVersion: String?
    ) {
        self.userId = userId
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
        self.creationVersion = creationVersion
    }

    init(userAuthInfo: UserAuthInfo, creationVersion: String?) {
        self.init(
            userId: userAuthInfo.uid,
            email: userAuthInfo.email,
            isAnonymous: userAuthInfo.isAnonymous,
            creationDate: userAuthInfo.creationDate,
            lastSignInDate: userAuthInfo.lastSignInDate,
            creationVersion: creationVersion
        )
    }

    enum CodingKeys: String, CodingKey {
        case userId = "user_id",
             email,
             didCompleteOnboarding = "did_complete_onboarding",
             profileColorHex = "profile_color_hex",
             isAnonymous = "is_anonymous",
             creationDate = "creation_date",
             lastSignInDate = "last_sign_in_date",
             creationVersion = "creation_version"
    }

	// MARK: - Mocks
	static var mock: Self {
		mocks.first!
	}

	static var mocks: [Self] {
		let formatter = ISO8601DateFormatter()

		return [
			UserModel(
				userId: "user1",
				didCompleteOnboarding: true,
				profileColorHex: "#33A1FF",
				email: "user1@example.com",
				isAnonymous: false,
				creationDate: formatter.date(from: "2025-07-20T10:15:00Z"),
				lastSignInDate: formatter.date(from: "2025-08-01T08:00:00Z"),
                creationVersion: "v1.1.0"
			),
			UserModel(
				userId: "user2",
				didCompleteOnboarding: false,
				profileColorHex: "#FF5733",
				email: "user2@example.com",
				isAnonymous: false,
				creationDate: formatter.date(from: "2025-07-21T14:45:00Z"),
				lastSignInDate: formatter.date(from: "2025-08-02T09:30:00Z"),
                creationVersion: "v1.1.0"
			),
			UserModel(
				userId: "user3",
				didCompleteOnboarding: true,
				profileColorHex: "#28A745",
				email: nil,
				isAnonymous: true,
				creationDate: formatter.date(from: "2025-07-22T09:00:00Z"),
				lastSignInDate: nil,
                creationVersion: "v1.1.0"
			),
			UserModel(
				userId: "user4",
				didCompleteOnboarding: nil,
				profileColorHex: nil,
				email: nil,
				isAnonymous: true,
				creationDate: nil,
				lastSignInDate: nil,
                creationVersion: "v1.1.0"
			)
		]
	}
}

extension UserModel: Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.userId == rhs.userId
    }
}
