//
//  ExploreView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            
            PrimaryCellView(
                title: AvatarModel.mock.name,
                subtitle: AvatarModel.mock.characterDescription?.characterDescription,
                imageUrl: Constants.randomImageUrl
            )
        }
    }
}

#Preview {
    ExploreView()
}
