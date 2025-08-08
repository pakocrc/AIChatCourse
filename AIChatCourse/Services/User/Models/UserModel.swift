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
	let dateCreated: Date?
	let didCompleteOnboarding: Bool?
	let profileColorHex: String?
	
	var profileColorCalculated: Color {
		guard let profileColorHex else {
			return Color.accent
		}
		
		return Color(hex: profileColorHex) ?? Color.accent
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
					dateCreated: formatter.date(from: "2025-07-20T10:15:00Z"),
					didCompleteOnboarding: true,
					profileColorHex: "#33A1FF"
				),
				UserModel(
					userId: "user2",
					dateCreated: formatter.date(from: "2025-07-21T14:45:00Z"),
					didCompleteOnboarding: false,
					profileColorHex: "#FF5733"
				),
				UserModel(
					userId: "user3",
					dateCreated: formatter.date(from: "2025-07-22T09:00:00Z"),
					didCompleteOnboarding: true,
					profileColorHex: "#28A745"
				),
				UserModel(
					userId: "user4",
					dateCreated: nil,
					didCompleteOnboarding: nil,
					profileColorHex: nil
				)
			]
		}
}
