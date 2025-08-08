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
					Text(chat.id)
				}
			}
			.navigationTitle("Chats")
		}
	}
}

#Preview {
	ChatsView()
}
