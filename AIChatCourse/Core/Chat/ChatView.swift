//
//  ChatView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 19/8/25.
//

import SwiftUI 

struct ChatView: View {
	@State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
	@State var avatar: AvatarModel? = .mock
	@State private var currentUser: UserModel? = .mock
	
	@State private var textFieldText: String = ""
	@State private var scrollPosition: String?

	@State private var presentChatSettings: AnyAppAlert?
	@State private var alertInfo: AnyAppAlert?
	
	@State private var showProfileModal: Bool = false
	
    var body: some View {
		VStack {
			chatViewSection
			
			textFieldSection
		}
		.navigationTitle(avatar?.name == nil ? "Chat" : "")
		.toolbarTitleDisplayMode(.inline)
		.toolbar {
			if let avatar {
				ToolbarItem(placement: .topBarLeading) {
					HStack(alignment: .center) {
						ImageLoaderView(imageUrlString: avatar.profileImageUrlString ?? "")
							.frame(width: 45, height: 45)
							.clipShape(Circle())
						
						Text(avatar.name ?? "Chat")
							.font(.title2)
							.fontWeight(.medium)
					}
					.anyButton(.plain) {
						showProfileModal = true
					}
				}
			}
			ToolbarItem(placement: .topBarTrailing) {
				Image(systemName: "ellipsis")
					.padding(8)
					.anyButton(.press) {
						displayChatSettings()
					}
			}
		}
		.showCustomAlert(type: .confirmationDialog, alertInfo: $presentChatSettings)
		.showCustomAlert(type: .alert, alertInfo: $alertInfo)
		.showModal(showModal: $showProfileModal) {
			if let avatar {
				ProfileModalView(avatar: avatar) {
					showProfileModal = false
				}
				.padding()
				.transition(AnyTransition.move(edge: .top).combined(with: .opacity))
			}
		}
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
		
		do {
			try TextValidationHelper.validateTextFieldText(text: textFieldText)
			
			let newChatMessage = ChatMessageModel(
				id: UUID().uuidString,
				chatId: UUID().uuidString,
				authorId: currentUser.userId,
				content: textFieldText,
				seenByIds: nil,
				dateCreated: .now
			)
			
			chatMessages.append(newChatMessage)
			
			scrollPosition = newChatMessage.id
			
			textFieldText = ""
			
		} catch let validationError as TextValidationHelper.TextValidationError {
			alertInfo = AnyAppAlert(
				title: validationError.rawValue,
				message: validationError.localizedDescription,
				buttons: {
					AnyView(
						Button("Got it!") {
							
						}
					)
				}
			)
			
		} catch {
			alertInfo = AnyAppAlert(error: error)
		}
	}
	
	private func displayChatSettings() {
		presentChatSettings = AnyAppAlert(
			title: "Settings",
			message: "What would you like to do?",
			buttons: {
				AnyView(
					Group {
						Button("Report User/Chat", role: .destructive) {
							
						}
						
						Button("Delete Chat", role: .destructive) {
							
						}
					}
				)
			}
		)
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

#Preview("Without Image") {
	NavigationStack {
		ChatView(avatar: nil)
	}
}
