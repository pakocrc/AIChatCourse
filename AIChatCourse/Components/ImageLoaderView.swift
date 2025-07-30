//
//  ImageLoaderView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct ImageLoaderView: View {
    var imageUrlString: String
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                
                AsyncImage(url: URL(string: imageUrlString)!) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .failure(let error):
                        Image(systemName: "photo.stack")
                            .resizable()
                            .scaledToFit()
                            .allowsHitTesting(false)
                            .onAppear(perform: {
                                debugPrint("Error downloading image: \(error)")
                            })
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: resizingMode)
                            .allowsHitTesting(false)
                        
                    @unknown default:
                        Image(systemName: "photo.stack")
                            .resizable()
                            .scaledToFit()
                            .allowsHitTesting(false)
                            .onAppear(perform: {
                                debugPrint("Unknown error downloading image")
                            })
                    }
                }
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView(imageUrlString: Constants.randomImageUrl)
}
