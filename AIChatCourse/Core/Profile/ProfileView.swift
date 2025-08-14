//
//  ProfileView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ProfileView: View {
	@State var userModel: UserModel?
	@State var myAvatars: [AvatarModel] = []
	
	@State private var showSettingsView: Bool = false
	@State private var showCreateNewAvatarView: Bool = false
	@State private var isLoading: Bool = true
	
	var body: some View {
		NavigationStack {
			List {
				profileInfoSection
				
				myAvatarsSection
			}
			.navigationTitle("Profile")
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					settingsButton
				}
			}
		}
		.sheet(isPresented: $showSettingsView) {
			SettingsView()
		}
		.fullScreenCover(isPresented: $showCreateNewAvatarView) {
			CreateAvatarView()
		}
		.task {
			await loadData()
		}
	}
	
	// MARK: - View Components
	private var profileInfoSection: some View {
		ZStack {
			Circle()
				.foregroundStyle(userModel?.profileColorCalculated ?? .accent)
				.frame(height: 120)
				.aspectRatio(1, contentMode: .fit)
				.frame(maxWidth: .infinity, alignment: .center)
		}
	}
	
	private var myAvatarsSection: some View {
		Section {
			if myAvatars.isEmpty {
				if isLoading {
					ProgressView()
						.frame(maxWidth: .infinity)
				} else {
					ContentUnavailableView(
						"No avatars yet",
						systemImage: "person.crop.circle",
						description:
							Text("Click + to create your first avatar")
					)
				}
			} else {
				ForEach(myAvatars, id: \.self) { item in
					PopularCellView(
						title: item.name ?? "Unknown",
						subtitle: nil,
						imageUrlString: item.profileImageUrlString
					)
					.anyButton(.highlight) {
						
					}
				}
				.onDelete(perform: { indexSet in
					onDeleteAvatar(atOffset: indexSet)
				})
				.removelistRowFormatting()
			}
		} header: {
			HStack {
				Text("My Avatars")
					.font(.headline)
					.fontWeight(.medium)
				
				Spacer()
				
				Image(systemName: "plus.circle.fill")
					.font(.title)
					.foregroundStyle(.accent)
					.anyButton(.press) {
						onShowCreateNewAvatarView()
					}
			}
		}
	}
	
	private var settingsButton: some View {
		Image(systemName: "gear")
			.font(.headline)
			.foregroundStyle(.accent)
			.anyButton(.press) {
				onSettingsButtonTap()
			}
	}
	
	// MARK: - Functions
	private func onSettingsButtonTap() {
		showSettingsView = true
	}
	
	private func onShowCreateNewAvatarView() {
		showCreateNewAvatarView.toggle()
	}
	
	private func onDeleteAvatar(atOffset indexSet: IndexSet) {
		guard let index = indexSet.first else { return }
		myAvatars.remove(at: index)
	}
	
	private func loadData() async {
		try? await Task.sleep(for: .seconds(2))
		myAvatars = AvatarModel.mocks
		isLoading = false
	}
}

#Preview {
	NavigationStack {
		ProfileView(
			userModel: UserModel.mock
		)
		.environment(AppState())
	}
}
