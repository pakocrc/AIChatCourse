//
//  ChatModel.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/8/25.
//

import Foundation

struct ChatModel: Codable, Identifiable {
	let id: String
	let userId: String
	let avatarId: String
	let dateCreated: Date
	let dateModified: Date
	
	// MARK: - Mocks
	static var mock: Self {
		mocks[0]
	}
	
	static var mocks: [Self] {
		let formatter = ISO8601DateFormatter()
		
		return [
			ChatModel(id: "mock_chat_1", userId: "user1", avatarId: "avatar1", dateCreated: formatter.date(from: "2025-08-01T12:00:00Z")!, dateModified: formatter.date(from: "2025-08-01T12:00:00Z")!),
			ChatModel(id: "mock_chat_2", userId: "user2", avatarId: "avatar2", dateCreated: formatter.date(from: "2025-08-02T13:15:00Z")!, dateModified: formatter.date(from: "2025-08-02T13:20:00Z")!),
			ChatModel(id: "mock_chat_3", userId: "user3", avatarId: "avatar3", dateCreated: formatter.date(from: "2025-08-03T14:30:00Z")!, dateModified: formatter.date(from: "2025-08-03T14:40:00Z")!),
			ChatModel(id: "mock_chat_4", userId: "user4", avatarId: "avatar4", dateCreated: formatter.date(from: "2025-08-04T15:45:00Z")!, dateModified: formatter.date(from: "2025-08-04T16:00:00Z")!),
			ChatModel(id: "mock_chat_5", userId: "user5", avatarId: "avatar5", dateCreated: formatter.date(from: "2025-08-05T16:00:00Z")!, dateModified: formatter.date(from: "2025-08-05T16:10:00Z")!),
			ChatModel(id: "mock_chat_6", userId: "user6", avatarId: "avatar6", dateCreated: formatter.date(from: "2025-08-06T17:20:00Z")!, dateModified: formatter.date(from: "2025-08-06T17:30:00Z")!)
		]
	}
}
