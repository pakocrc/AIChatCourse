//
//  PopularCellView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/8/25.
//

import SwiftUI

struct PopularCellView: View {
	var title: String?
	var subtitle: String?
	var imageUrlString: String? = Constants.randomImageUrl
	
    var body: some View {
		HStack(spacing: 10) {
			if let imageUrlString = imageUrlString {
				ImageLoaderView(imageUrlString: imageUrlString)
					.aspectRatio(1, contentMode: .fit)
					.frame(height: 50)
					.cornerRadius(8)
				
			} else {
				Rectangle()
					.foregroundStyle(.gray)
					.aspectRatio(1, contentMode: .fit)
					.frame(height: 50)
					.cornerRadius(8)
			}

			VStack(alignment: .leading, spacing: 5) {
				Text(title ?? "")
					.font(.headline)
				
				Text(subtitle ?? "")
					.font(.subheadline)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
		.padding()
		.background(Color(uiColor: UIColor.systemBackground))
    }
}

#Preview {
	ZStack {
		Color.gray.ignoresSafeArea()
		
		VStack {
			PopularCellView(
				title: AvatarModel.mock.name,
				subtitle: AvatarModel.mock.characterDescription?.characterDescription ?? "",
				imageUrlString: AvatarModel.mock.profileImageUrlString ?? ""
			)
			
			PopularCellView(
				title: nil,
				subtitle: AvatarModel.mock.characterDescription?.characterDescription ?? "",
				imageUrlString: AvatarModel.mock.profileImageUrlString ?? ""
			)
			
			PopularCellView(
				title: AvatarModel.mock.name!,
				subtitle: nil,
				imageUrlString: AvatarModel.mock.profileImageUrlString ?? ""
			)
			
			PopularCellView(
				title: AvatarModel.mock.name!,
				subtitle: AvatarModel.mock.characterDescription?.characterDescription ?? "",
				imageUrlString: nil
			)
			
			PopularCellView(
				title: nil,
				subtitle: nil,
				imageUrlString: nil
			)
		}
	}
}
