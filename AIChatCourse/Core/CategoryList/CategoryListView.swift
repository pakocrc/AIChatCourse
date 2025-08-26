//
//  CategoryListView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 21/8/25.
//

import SwiftUI

struct CategoryListView: View {
	var category: CharacterOption = .alien
	var imageName: String = Constants.randomImageUrl
	
	@Binding var path: [NavigationPathOption]
	
	@State private var avatars: [AvatarModel] = AvatarModel.mocks
	
	var body: some View {
		List {
			CategoryCellView(
				title: category.pluralized.capitalized,
				imageUrlString: imageName,
				cornerRadius: 0,
				customFont: .title
			)
			.removelistRowFormatting()
			
			ForEach(avatars, id: \.avatarId) { avatar in
				PopularCellView(
					title: avatar.name,
					subtitle: avatar.characterDescription?.characterDescription,
					imageUrlString: Constants.randomImageUrl
				)
				.anyButton(.highlight) {
					onAvatarPressed(avatar)
				}
			}
			.removelistRowFormatting()
		}
		.ignoresSafeArea()
		.listStyle(PlainListStyle())
	}
	
	// MARK: - Actions
	private func onAvatarPressed(_ avatar: AvatarModel) {
		path.append(.chat(avatar: avatar))
	}
}

#Preview {
	CategoryListView(path: .constant([]))
}
