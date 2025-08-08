//
//  ExploreView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ExploreView: View {
    
    private var featuredAvatars: [AvatarModel] = AvatarModel.mocks
    private var categories: [CharacterOption] = CharacterOption.allCases
	private var popularAvatars: [AvatarModel] = AvatarModel.mocks
    
    var body: some View {
        NavigationStack {
            
            List {
                featuredSection
                
                categoriesSection
				
				popularSection
            }
            
            .navigationTitle("Explore")
        }
    }
    
    private var featuredSection: some View {
        Section {
            ZStack {
                CarouselView(items: featuredAvatars) { item in
                    PrimaryCellView(
                        title: item.name,
                        subtitle: item.characterDescription?.characterDescription,
                        imageUrlString: Constants.randomImageUrl
                    )
					.anyButton {
						
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
                    ForEach(categories, id: \.self) { item in
                        CategoryCellView(
                            title: item.rawValue,
                            imageUrlString: Constants.randomImageUrl
                        )
						.anyButton {
							
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
			ForEach(popularAvatars, id: \.avatarId) { item in
				PopularCellView(
					title: item.name,
					subtitle: item.characterDescription?.characterDescription,
					imageUrlString: Constants.randomImageUrl
				)
				.anyButton(.highlight) {
					
				}
			}
			
		} header: {
			Text("Popular")
				.font(.headline)
		}
		.removelistRowFormatting()
	}
}

#Preview {
    NavigationStack {
        ExploreView()
    }
}
