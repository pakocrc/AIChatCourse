//
//  ChatView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 19/8/25.
//

import SwiftUI

struct ChatView: View {
	@State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
	@State private var avatar: AvatarModel? = .mock
	@State private var currentUser: UserModel? = .mock
	
    var body: some View {
		VStack {
			ScrollView {
				LazyVStack(spacing: 25) {
					ForEach(chatMessages, id: \.id) { message in
						let isCurrentUser = message.authorId == currentUser?.userId
						
						ChatBubbleViewBuilder(
							chatMessage: message,
							isCurrentUser: isCurrentUser,
							imageName: avatar?.profileImageUrlString
						)
					}
				}
			}
			.frame(maxWidth: .infinity)
			.padding()
			
			Rectangle()
				.frame(height: 45)
		}
		.navigationTitle(avatar?.name ?? "Chat")
		.toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
	NavigationStack {
		ChatView()
	}
}
