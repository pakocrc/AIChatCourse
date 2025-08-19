//
//  ChatRowBuilder.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 8/8/25.
//

import SwiftUI

struct ChatRowBuilder: View {
	var chat: ChatModel?
	
	var getAvatar: () async -> AvatarModel?
	var getLastChatMessage: () async -> ChatMessageModel?
	
	@State private var avatar: AvatarModel?
	@State private var lastChatMessage: ChatMessageModel?
	
	@State private var didLoadAvatar: Bool = false
	@State private var didLoadLastChatMessage: Bool = false
	
	private var isLoading: Bool {
		(didLoadAvatar && didLoadLastChatMessage) ? false : true
	}
	
	private var hasNewChat: Bool {
		guard let lastChatMessage else { return false }
		return lastChatMessage.seenByCurrentUser(userId: chat?.userId ?? "")
	}

	var body: some View {
		ChatCellView(
			imageName: Constants.randomImageUrl,
			headline: avatar?.name,
			subheadline: lastChatMessage?.content,
			hasNewMessage: isLoading ? false : hasNewChat
		)
		.redacted(reason: isLoading ? .placeholder : [])
		.task {
			avatar = await getAvatar()
			didLoadAvatar = true
		}
		.task {
			lastChatMessage = await getLastChatMessage()
			didLoadLastChatMessage = true
		}
	}
}

#Preview {
	List {		
		ChatRowBuilder(
			chat: .mock,
			getAvatar: {
				try? await Task.sleep(for: .seconds(1))
				return AvatarModel.mock
			},
			getLastChatMessage: {
				try? await Task.sleep(for: .seconds(2))
				return ChatMessageModel.mock
			}
		)
		
		ChatRowBuilder(
			chat: .mock,
			getAvatar: {
				try? await Task.sleep(for: .seconds(3))
				return AvatarModel.mocks[1]
			},
			getLastChatMessage: {
				try? await Task.sleep(for: .seconds(2))
				return ChatMessageModel.mocks[1]
			}
		)
		
		ChatRowBuilder(
			chat: nil,
			getAvatar: {
				try? await Task.sleep(for: .seconds(2))
				return nil
			},
			getLastChatMessage: {
				try? await Task.sleep(for: .seconds(3))
				return nil
			}
		)
	}
}
