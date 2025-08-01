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
            
            
            ScrollView(.horizontal) {
                ForEach(AvatarModel.mocks, id: \.avatarId) { avatar in
                    PrimaryCellView(
                        title: avatar.name,
                        subtitle: avatar.characterDescription?.characterDescription,
                        imageUrl: Constants.randomImageUrl
                    )
                    .frame(width: 300, height: 200)
                }
            }
//            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ExploreView()
}
