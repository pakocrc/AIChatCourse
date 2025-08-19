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
	
	@State private var textFieldText: String = ""
	@State private var presentChatSettings: Bool = false
	@State private var scrollPosition: String?
	
    var body: some View {
		VStack {
			chatViewSection
			
			textFieldSection
		}
		.navigationTitle(avatar?.name ?? "Chat")
		.toolbarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Image(systemName: "ellipsis")
					.padding(8)
					.anyButton {
						presentChatSettings = true
					}
			}
		}
		.confirmationDialog("Title", isPresented: $presentChatSettings) {
			Button("Report User/Chat", role: .destructive) {
				
			}
			Button("Delete Chat", role: .destructive) {
				
			}

			Button("Cancel", role: .cancel) {
				presentChatSettings = false
			}
		} message: { Text("What would you like to do?" ) }
	}
	
	private var chatViewSection: some View {
		ScrollView {
			LazyVStack(spacing: 25) {
				ForEach(chatMessages, id: \.id) { message in
					let isCurrentUser = message.authorId == currentUser?.userId
					
					ChatBubbleViewBuilder(
						chatMessage: message,
						isCurrentUser: isCurrentUser,
						imageName: avatar?.profileImageUrlString
					)
					.id(message.id)
				}
			}
		}
		.frame(maxWidth: .infinity)
		.padding()
		.scrollPosition(id: $scrollPosition, anchor: .center)
		.animation(.default, value: chatMessages.count)
		.animation(.default, value: scrollPosition)
	}
	
	private var textFieldSection: some View {
		TextField("Say something...", text: $textFieldText)
			.keyboardType(.alphabet)
			.autocorrectionDisabled()
			.padding(10)
			.padding(.trailing, 45)
			.overlay(alignment: .trailing, content: {
				Image(systemName: "arrow.up.circle.fill")
					.font(.system(size: 32))
					.padding(.trailing, 4)
					.foregroundStyle(textFieldText.isEmpty ? .gray : .accent)
					.anyButton(.press) {
						onSendButtonTapped()
					}
					.disabled(textFieldText.isEmpty)
			})
			.background(
				ZStack {
					RoundedRectangle(cornerRadius: 100)
						.fill(Color.gray.opacity(0.1))
					
					RoundedRectangle(cornerRadius: 100)
						.stroke(.gray.opacity(0.5), lineWidth: 1)
				}
			)
			.padding()
	}
	
	private func onSendButtonTapped() {
		guard let currentUser = currentUser else { return }
		
		let content = textFieldText
		
		let newChatMessage = ChatMessageModel(
			id: UUID().uuidString,
			chatId: UUID().uuidString,
			authorId: currentUser.userId,
			content: content,
			seenByIds: nil,
			dateCreated: .now
		)
		
		chatMessages.append(newChatMessage)
		
		scrollPosition = newChatMessage.id
		
		textFieldText = ""
	}
}

#Preview("Light Mode") {
	NavigationStack {
		ChatView()
	}
}

#Preview("Dark Mode") {
	NavigationStack {
		ChatView()
	}
	.preferredColorScheme(.dark)
}
