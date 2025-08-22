//
//  ChatsView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ChatsView: View {
	@State private var chats: [ChatModel] = ChatModel.mocks
	
	@State private var path: [NavigationPathOption] = []
	
	var body: some View {
		NavigationStack(path: $path) {
			List {
				ForEach(chats, id: \.id) { chat in
					ChatRowBuilder(
						chat: chat,
						getAvatar: {
							try? await Task.sleep(for: .seconds(Int.random(in: 1...5)))
							return AvatarModel.mocks.randomElement()!
						},
						getLastChatMessage: {
							try? await Task.sleep(for: .seconds(Int.random(in: 1...5)))
							return ChatMessageModel.mocks.randomElement()!
						}
					)
					.anyButton {
						onAvatarPressed(AvatarModel.mock)
					}
				}
			}
			.navigationTitle("Chats")
			.navigationDestinationForCoreModule()
		}
	}
	
	// MARK: - Actions
	private func onAvatarPressed(_ avatar: AvatarModel) {
		path.append(.chat(avatar: avatar))
	}
}

#Preview {
	ChatsView()
}
