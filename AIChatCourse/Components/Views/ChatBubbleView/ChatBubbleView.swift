//
//  ChatBubbleView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 19/8/25.
//

import SwiftUI

struct ChatBubbleView: View {
	
	var text: String = "Sample text..."
	var textColor: Color = .primary
	var backgroundColor: Color = Color(uiColor: .systemGray4)
	var imageName: String?
	var showImage: Bool = true
	
	let offset: CGFloat = 14
	
    var body: some View {
		HStack(alignment: .top, spacing: 10) {
			if showImage {
				ZStack {
					if let imageName {
						ImageLoaderView(imageUrlString: imageName)
					} else {
						Rectangle()
							.fill(.secondary)
					}
				}
				.frame(width: 45, height: 45)
				.clipShape(Circle())
				.offset(y: offset)
			}
			
			Text(text)
				.font(.body)
				.foregroundStyle(textColor)
				.padding(.horizontal, 20)
				.padding(.vertical, 10)
				.background(backgroundColor)
				.clipShape(RoundedRectangle(cornerRadius: 15))
		}
		.padding(.bottom, offset)
    }
}

#Preview {
	ScrollView {
		VStack(spacing: 15) {
			ChatBubbleView()
			ChatBubbleView(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim. Nullam eget metus id nisl malesuada condimentum.")
			ChatBubbleView()
			
			ChatBubbleView(
				text: "This is a test message",
				textColor: .white,
				backgroundColor: .accent,
				showImage: false
			)
			ChatBubbleView(
				text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim. Nullam eget metus id nisl malesuada condimentum.",
				textColor: .white,
				backgroundColor: .accent,
				showImage: false
			)
		}
	}
}
