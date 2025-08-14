//
//  CreateAvatarView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 13/8/25.
//

import SwiftUI

struct CreateAvatarView: View {
	@Environment(\.dismiss) var dismiss
	
	@State private var avatarName: String = ""
	@State private var imageUrlString: String?
	@State private var characterOption: CharacterOption = .default
	@State private var characterAction: CharacterAction = .default
	@State private var characterLocation: CharacterLocation = .default
	
	@State private var isGeneratingImage: Bool = false
	@State private var isFormComplete: Bool = false
	@State private var isSaving: Bool = false
	
	var body: some View {
		NavigationStack {
			List {
				nameSection
				
				attributesSection
				
				imageGenerationSection
			}
			.navigationTitle("Create Avatar")
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					closeButton
				}
			}
			
			footerButton
		}
	}
	
	private var closeButton: some View {
		Image(systemName: "xmark")
			.font(.title2)
			.fontWeight(.semibold)
			.foregroundStyle(.accent)
			.anyButton {
				dismiss()
			}
	}
	
	private var nameSection: some View {
		Section {
			TextField("Name", text: $avatarName)
			
		} header: {
			Text("Name your avatar")
		}
	}
	
	private var attributesSection: some View {
		Section {
			Picker(selection: $characterOption) {
				ForEach(CharacterOption.allCases, id: \.self) { option in
					Text(option.rawValue.capitalized)
						.tag(option)
				}
			} label: {
				Text("is a")
			}
			
			Picker(selection: $characterAction) {
				ForEach(CharacterAction.allCases, id: \.self) { option in
					Text(option.rawValue.capitalized)
						.tag(option)
				}
			} label: {
				Text("that is")
			}
			
			Picker(selection: $characterLocation) {
				ForEach(CharacterLocation.allCases, id: \.self) { option in
					Text(option.rawValue.capitalized)
						.tag(option)
				}
			} label: {
				Text("in the")
			}
			
		} header: {
			Text("The avatar")
		}
	}
	
	private var imageGenerationSection: some View {
		Group {
			HStack {
				Text("Generate image")
					.foregroundStyle(.accent)
					.font(.headline)
					.fontWeight(.semibold)
				
				Image(systemName: "paintpalette")
					.foregroundStyle(.accent)
					.font(.headline)
			}
			.anyButton(.press) {
				isGeneratingImage = true
				imageUrlString = ""
				imageUrlString = Constants.randomImageUrl
			}
			.frame(maxWidth: .infinity)
			
			Circle()
				.foregroundStyle(.gray)
				.overlay(content: {
					ImageLoaderView(imageUrlString: imageUrlString ?? "", resultingImage: { image in
						// image
						isFormComplete = true
						isGeneratingImage = false
					})
						.clipShape(Circle())
						.scaledToFill()
						.disabled(isGeneratingImage)
						
				})
				.frame(width: 150)
				.frame(maxWidth: .infinity)
				.padding(.horizontal)
		}
	}
	
	private var footerButton: some View {
		AsyncCallToActionButton(title: "Save", isEnabled: isFormComplete, isLoading: isSaving) {
			
		}
	}
}

#Preview {
	CreateAvatarView()
}
