//
//  ChatBubbleViewBuilder.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 19/8/25.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {
	
	var chatMessage: ChatMessageModel = .mock
	var isCurrentUser: Bool = false
	var imageName: String?
	
    var body: some View {
		ZStack {
			ChatBubbleView(
				text: chatMessage.content ?? "",
				textColor: isCurrentUser ? .white : .primary,
				backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray4),
				imageName: imageName,
				showImage: !isCurrentUser
			)
		}
		.frame(maxWidth: .infinity, alignment: isCurrentUser ? .trailing : .leading)
		.padding(.leading, isCurrentUser ? 75 : 0)
		.padding(.trailing, isCurrentUser ? 0 : 74)
	}
}

#Preview {
	ScrollView {
		VStack(spacing: 24) {
			ChatBubbleViewBuilder()
			
			ChatBubbleViewBuilder(isCurrentUser: true)
			
			ChatBubbleViewBuilder(
				chatMessage: ChatMessageModel(
					id: UUID().uuidString,
					chatId: UUID().uuidString,
					authorId: UUID().uuidString,
					content: "Hola, soy Francisco Cordoba",
					seenByIds: [],
					dateCreated: Date.now
				),
				isCurrentUser: false,
				imageName: nil
			)
			
			ChatBubbleViewBuilder(
				chatMessage: ChatMessageModel(
					id: UUID().uuidString,
					chatId: UUID().uuidString,
					authorId: UUID().uuidString,
					content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
					seenByIds: [],
					dateCreated: Date.now
				),
				isCurrentUser: true,
			)
		}
		.padding()
	}
}
