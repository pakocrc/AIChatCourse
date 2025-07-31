//
//  PrimaryCellView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 30/7/25.
//

import SwiftUI

struct PrimaryCellView: View {
    
    var title: String?
    var subtitle: String?
    var imageUrl: String?
    
    var body: some View {
        ZStack {
            if let imageUrl {
                ImageLoaderView(imageUrlString: imageUrl)
            } else {
                Rectangle()
                    .fill(.accent)
            }
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 5) {
                
                if let title {
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                if let subtitle {
                    Text(subtitle)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.light)
                }
            }
            .padding()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(colors: [Color.black.opacity(0.1),
                                        Color.black.opacity(0.3),
                                        Color.black.opacity(0.4)],
                               startPoint: .top,
                               endPoint: .bottom)
            )
        }
        .cornerRadius(10.0)
        .shadow(color: .black, radius: 2.0)
    }
}

#Preview {
    ScrollView {
        VStack {
            PrimaryCellView(
                title: "Title",
                subtitle: "Subtitle subtitle subtitle",
                imageUrl: Constants.randomImageUrl
            )
            .frame(width: 300, height: 200, alignment: .center)
            
            PrimaryCellView(
                title: "Title",
                subtitle: "Subtitle subtitle subtitle",
                imageUrl: nil
            )
            .frame(width: 300, height: 200, alignment: .center)
            
            PrimaryCellView(
                title: "Title",
                subtitle: "Subtitle subtitle subtitle",
                imageUrl: Constants.randomImageUrl
            )
            .frame(width: 300, height: 200, alignment: .center)
            
            PrimaryCellView(
                title: nil,
                subtitle: "Subtitle subtitle subtitle",
                imageUrl: Constants.randomImageUrl
            )
            .frame(width: 300, height: 200, alignment: .center)
            
            PrimaryCellView(
                title: "Title",
                subtitle: nil,
                imageUrl: Constants.randomImageUrl
            )
            .frame(width: 300, height: 200, alignment: .center)
            
            PrimaryCellView(
                title: "Title",
                subtitle: nil,
                imageUrl: Constants.randomImageUrl
            )
            .frame(width: 400, height: 300, alignment: .center)
            
            PrimaryCellView(
                title: "Title",
                subtitle: "Subtitle subtitle subtitle",
                imageUrl: Constants.randomImageUrl
            )
            .frame(width: 100, height: 100, alignment: .center)
        }
        .frame(maxWidth: .infinity)
    }
}
