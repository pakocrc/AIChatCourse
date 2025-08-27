//
//  ChatsView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ChatsView: View {
	@State private var chats: [ChatModel] = ChatModel.mocks
	@State private var recentAvatars: [AvatarModel] = AvatarModel.mocks
	@State private var path: [NavigationPathOption] = []
	
	var body: some View {
		NavigationStack(path: $path) {
			List {
				recentsSection
				
				chatsSection
			}
			.navigationTitle("Chats")
			.navigationDestinationForCoreModule(path: $path)
		}
	}
	
	// MARK: - UI Components
	private var recentsSection: some View {
		Section {
			if recentAvatars.isEmpty {
				Text("Your recent chats will appear here")
					.foregroundStyle(.secondary)
					.font(.title3)
					.frame(maxWidth: .infinity)
					.multilineTextAlignment(.center)
					.padding()
					.removelistRowFormatting()
				
			} else {
				ScrollView(.horizontal) {
					LazyHStack(spacing: 8) {
						ForEach(recentAvatars, id: \.avatarId) { avatar in
							if let imageName = avatar.profileImageUrlString {
								VStack(spacing: 8) {
									ImageLoaderView(imageUrlString: imageName)
										.aspectRatio(1, contentMode: .fit)
										.clipShape(Circle())
									
									Text(avatar.name ?? "")
										.font(.caption)
										.foregroundStyle(.secondary)
								}
								.anyButton(.plain) {
									onAvatarPressed(avatar)
								}
							}
						}
					}
					.padding(.top, 12)
				}
				.frame(height: 120)
				.scrollIndicators(.hidden)
				.removelistRowFormatting()
			}
		} header: {
			Text("Recents")
		}
	}

	private var chatsSection: some View {
		Section {
			if chats.isEmpty {
				Text("Your chats will appear here")
					.foregroundStyle(.secondary)
					.font(.title3)
					.frame(maxWidth: .infinity)
					.multilineTextAlignment(.center)
					.padding()
					.removelistRowFormatting()
				
			} else {
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
		} header: {
			Text("Chats")
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
