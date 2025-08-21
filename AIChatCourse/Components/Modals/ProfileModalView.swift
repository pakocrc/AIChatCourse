//
//  ProfileModalView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 20/8/25.
//

import SwiftUI

struct ProfileModalView: View {
	
	var avatar: AvatarModel = .mock
	var onCloseButtonTapped: () -> Void
	
	var body: some View {
		VStack(alignment: .leading) {
			ImageLoaderView(imageUrlString: avatar.profileImageUrlString ?? "")
				.aspectRatio(1, contentMode: .fit)
			
			VStack(alignment: .leading) {
				Text(avatar.name ?? "")
					.font(.title)
					.fontWeight(.bold)
				
				Text(avatar.characterOption?.rawValue.capitalized ?? "")
					.font(.title3)
					.foregroundStyle(.secondary)
			}
			.padding()
		}
		.background(.thinMaterial)
		.clipShape(RoundedRectangle(cornerRadius: 15))
		.overlay(alignment: .topTrailing, content: {
			Image(systemName: "xmark.circle.fill")
				.font(.title2)
				.foregroundStyle(.black)
				.padding()
				.tappableBackground()
				.anyButton {
					onCloseButtonTapped()
				}
		})
	}
}

#Preview("Light"){
	ZStack {
		Color.gray.ignoresSafeArea()
		
		ProfileModalView(onCloseButtonTapped: {
			
		}).padding()
	}
}

#Preview("Dark") {
	
	ProfileModalView(onCloseButtonTapped: {
		
	})
	.padding()
	.preferredColorScheme(.dark)
}
