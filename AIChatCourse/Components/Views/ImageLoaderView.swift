//
//  ImageLoaderView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ImageLoaderView: View {
    var imageUrlString: String
    var resizingMode: ContentMode = .fill
	var resultingImage: (Image) -> Void = { _ in }

    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
				if let url = URL(string: imageUrlString) {
					AsyncImage(url: url) { phase in
						switch phase {
						case .empty:
							ProgressView()
						case .failure(let error):
							Image(systemName: "photo.stack")
								.resizable()
								.scaledToFit()
								.allowsHitTesting(false)
								.onAppear(perform: {
									debugPrint("Error downloading image: \(error)")
								})
							
						case .success(let image):
							image
								.resizable()
								.aspectRatio(contentMode: resizingMode)
								.allowsHitTesting(false)
								.onAppear {
									resultingImage(image)
								}
							
						@unknown default:
							Image(systemName: "photo")
								.resizable()
								.scaledToFit()
								.allowsHitTesting(false)
								.onAppear(perform: {
									debugPrint("Unknown error downloading image")
								})
								.foregroundStyle(.gray)
						}
					}
					.accessibilityLabel(Text("Image"))
				} else {
					Image(systemName: "photo")
						.resizable()
						.scaledToFit()
						.allowsHitTesting(false)
						.foregroundStyle(.gray)
				}
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView(imageUrlString: Constants.randomImageUrl)
		.frame(width: 300, height: 300)
	
	ImageLoaderView(imageUrlString: "")
		.frame(width: 300, height: 300)
}
