//
//  ChatsView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ChatsView: View {
	@State private var chats: [ChatModel] = ChatModel.mocks
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(chats, id: \.id) { chat in
					ChatRowBuilder(
						chat: chat,
						getAvatar: {
							try? await Task.sleep(for: .seconds(Int.random(in: 1...5)))
							return AvatarModel.mock
						},
						getLastChatMessage: {
							try? await Task.sleep(for: .seconds(Int.random(in: 1...5)))
							return ChatMessageModel.mock
						}
					)
					.anyButton(.highlight) {
						
					}
				}
			}
			.navigationTitle("Chats")
		}
	}
}

#Preview {
	ChatsView()
}
