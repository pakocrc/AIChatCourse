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
    
    var body: some View {
        NavigationStack {
            
            List {
                featuredSection
                
                categoriesSection
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
}

#Preview {
    NavigationStack {
        ExploreView()
    }
}
