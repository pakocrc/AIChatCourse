//
//  ChatMessageModel.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/8/25.
//

import Foundation

struct ChatMessageModel: Codable {
	let id: String
	let chatId: String
	let authorId: String?
	let content: String?
	let seenByIds: [String]?
	let dateCreated: Date?
	
	func seenByCurrentUser(userId: String) -> Bool {
		guard let seen = seenByIds?.contains(where: { $0 == userId }) else { return false }
		return seen
	}
	
	// MARK: - Mocks
	static var mock: ChatMessageModel {
		mocks[0]
	}
	
	static var mocks: [ChatMessageModel] {
		let formatter = ISO8601DateFormatter()
		
		return [
			ChatMessageModel(
				id: "msg1",
				chatId: "1",
				authorId: "user1",
				content: "Hey, how are you?",
				seenByIds: ["user2", "user3"],
				dateCreated: formatter.date(from: "2025-08-01T12:00:00Z")
			),
			ChatMessageModel(
				id: "msg2",
				chatId: "1",
				authorId: "user2",
				content: "I'm good, thanks! You?",
				seenByIds: ["user1", "user3"],
				dateCreated: formatter.date(from: "2025-08-01T12:01:00Z")
			),
			ChatMessageModel(
				id: "msg3",
				chatId: "2",
				authorId: "user4",
				content: "Meeting at 3PM.",
				seenByIds: nil,
				dateCreated: formatter.date(from: "2025-08-02T09:30:00Z")
			),
			ChatMessageModel(
				id: "msg4",
				chatId: "2",
				authorId: "user5",
				content: "Got it.",
				seenByIds: ["user4"],
				dateCreated: formatter.date(from: "2025-08-02T09:35:00Z")
			),
			ChatMessageModel(
				id: "msg5",
				chatId: "3",
				authorId: "user6",
				content: "Can you review the code?",
				seenByIds: [],
				dateCreated: formatter.date(from: "2025-08-03T18:45:00Z")
			),
			ChatMessageModel(
				id: "msg6",
				chatId: "3",
				authorId: nil,
				content: nil,
				seenByIds: nil,
				dateCreated: nil
			)
		]
	}
}
