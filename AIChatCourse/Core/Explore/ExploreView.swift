//
//  ExploreView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

enum NavigationPathOption: Hashable {
	case chat(avatar: AvatarModel)
	case category(category: CharacterOption)
}

extension View {
	func navigationDestinationForCoreModule() -> some View {
		self
			.navigationDestination(for: NavigationPathOption.self) { newValue in
				switch newValue {
				case .chat(let avatar):
					ChatView(avatar: avatar)
				case .category(let category):
					CategoryListView(category: category)
				}
			}
	}
}

struct ExploreView: View {
    
    private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    private var categories: [CharacterOption] = CharacterOption.allCases
	private var popularAvatars: [AvatarModel] = AvatarModel.mocks
	
	@State private var path: [NavigationPathOption] = []
    
    var body: some View {
		NavigationStack(path: $path) {
            
            List {
                featuredSection
                
                categoriesSection
				
				popularSection
            }
            
            .navigationTitle("Explore")
			.navigationDestinationForCoreModule()
        }
    }
    
	// MARK: - View Components
    private var featuredSection: some View {
        Section {
            ZStack {
                CarouselView(items: featuredAvatars) { avatar in
                    PrimaryCellView(
                        title: avatar.name,
                        subtitle: avatar.characterDescription?.characterDescription,
                        imageUrlString: Constants.randomImageUrl
                    )
					.anyButton(.highlight) {
						onAvatarPressed(avatar)
					}
                }
            }
            .removelistRowFormatting()
        } header: {
            Text("Featured Avatars")
                .font(.headline)
        }
    }
    
    private var categoriesSection: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(categories, id: \.self) { category in
                        CategoryCellView(
                            title: category.rawValue,
                            imageUrlString: Constants.randomImageUrl
                        )
						.anyButton {
							onCategoryPressed(category)
						}
					}
                }
                .frame(height: 130)
                .scrollTargetBehavior(.viewAligned)
            }
            .scrollIndicators(.hidden)
            .removelistRowFormatting()
            
        } header: {
            Text("Categories")
                .font(.headline)
        }
    }
	
	private var popularSection: some View {
		Section {
			ForEach(popularAvatars, id: \.avatarId) { avatar in
				PopularCellView(
					title: avatar.name,
					subtitle: avatar.characterDescription?.characterDescription,
					imageUrlString: Constants.randomImageUrl
				)
				.anyButton(.highlight) {
					onAvatarPressed(avatar)
				}
			}
			
		} header: {
			Text("Popular")
				.font(.headline)
		}
		.removelistRowFormatting()
	}
	
	// MARK: - Actions
	private func onAvatarPressed(_ avatar: AvatarModel) {
		path.append(.chat(avatar: avatar))
	}
	
	private func onCategoryPressed(_ category: CharacterOption) {
		path.append(.category(category: category))
	}
}

#Preview {
    NavigationStack {
        ExploreView()
    }
}
