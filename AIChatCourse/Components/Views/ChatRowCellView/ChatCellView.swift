//
//  ChatCellView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/8/25.
//

import SwiftUI

struct ChatCellView: View {
	var imageName: String?
	var headline: String?
	var subheadline: String?
	var hasNewMessage: Bool = false
	
	private let unknownHeader: String = "Unknown"
	private let unknownSubheader: String = "Unknown message"
	private let newText: String = "NEW"
	
	var body: some View {
		HStack(spacing: 15) {
			if let imageName {
				ImageLoaderView(imageUrlString: imageName)
					.aspectRatio(1, contentMode: .fit)
					.frame(height: 50)
					.clipShape(Circle())
			} else {
				Image(systemName: "person.circle")
					.resizable()
					.aspectRatio(1, contentMode: .fit)
					.frame(height: 50)
					.clipShape(Circle())
					.opacity(0.5)
			}
			
			VStack(alignment: .leading, spacing: 5) {
				Text(headline ?? unknownHeader)
					.font(.headline)
				
				Text(subheadline ?? unknownSubheader)
					.font(.subheadline)
					.foregroundStyle(Color.secondary)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			if hasNewMessage {
				Text(newText)
					.foregroundStyle(.white)
					.font(.caption)
					.fontWeight(.medium)
					.padding(4)
					.background(Color.blue)
					.clipShape(.buttonBorder)
			}
		}
    }
}

#Preview {
	List {
		ChatCellView(
			imageName: Constants.randomImageUrl,
			headline: "Alpha",
			subheadline: "Hello, how are you?",
			hasNewMessage: true
		)
		ChatCellView(
			imageName: nil,
			headline: "Alpha",
			subheadline: "Hello, how are you?",
			hasNewMessage: false
		)
		ChatCellView(
			imageName: Constants.randomImageUrl,
			headline: nil,
			subheadline: "Hello, how are you?",
			hasNewMessage: false
		)
		ChatCellView(
			imageName: Constants.randomImageUrl,
			headline: "Alpha",
			subheadline: nil,
			hasNewMessage: false
		)
		ChatCellView(
			imageName: Constants.randomImageUrl,
			headline: "Alpha",
			subheadline: "Hello, how are you?",
			hasNewMessage: true
		)
		ChatCellView(
			imageName: nil,
			headline: nil,
			subheadline: nil,
			hasNewMessage: false
		)
	}
}
