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
			
			ForEach(avatars, id: \.avatarId) { item in
				PopularCellView(
					title: item.name,
					subtitle: item.characterDescription?.characterDescription,
					imageUrlString: Constants.randomImageUrl
				)
				.anyButton(.highlight) {
					
				}
			}
			.removelistRowFormatting()
		}
		.ignoresSafeArea()
		.listStyle(PlainListStyle())
	}
}

#Preview {
    CategoryListView()
}
