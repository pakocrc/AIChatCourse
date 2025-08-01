//
//  CategoryCellView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 31/7/25.
//

import SwiftUI

struct CategoryCellView: View {
    var title: String?
    var imageUrlString: String?
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        ZStack {
            if let imageUrlString {
                ImageLoaderView(imageUrlString: imageUrlString)
                    .aspectRatio(1, contentMode: .fit)
            } else {
                Rectangle()
                    .fill(.accent)
            }
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 5) {
                
                if let title {
                    Text(title.capitalized)
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .gradientBackgroundForText()
        }
        .cornerRadius(cornerRadius)
        .shadow(color: .black, radius: 2.0)
    }
}

#Preview {
    VStack {
        CategoryCellView(
            title: "Test",
            imageUrlString: Constants.randomImageUrl
        )
        .frame(width: 120)
        
        CategoryCellView(
            title: "Test",
            imageUrlString: Constants.randomImageUrl
        )
        .frame(width: 200)
    }
}
