//
//  CreateAvatarView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 13/8/25.
//

import SwiftUI

struct CreateAvatarView: View {
	@Environment(\.dismiss) private var dismiss
    @Environment(AIManager.self) private var aiManager

	@State private var avatarName: String = ""
	@State private var generatedImage: UIImage?
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
				onGenerateImagePressed()
			}
			.frame(maxWidth: .infinity)
			
			Circle()
				.foregroundStyle(.gray)
				.overlay(content: {
                    if let generatedImage {
                        Image(uiImage: generatedImage)
                            .clipShape(Circle())
                            .scaledToFill()
                            .disabled(isGeneratingImage)
                    }

                    if isGeneratingImage {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.0)
                    }
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

    private func onGenerateImagePressed() {
        isGeneratingImage = true

        Task {
            do {

                let prompt = CharacterDescriptionBuilder(
                    characterOption: characterOption,
                    characterAction: characterAction,
                    characterLocation: characterLocation
                )

                generatedImage = try await aiManager.generateImage(prompt: prompt.characterDescription)

            } catch {
                print("Error generating image: \(error)")
            }

            isGeneratingImage = false
        }
    }
}

#Preview {
	CreateAvatarView()
        .environment(AIManager(service: MockAIService()))
}
