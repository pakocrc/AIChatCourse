//
//  View+callToAction.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

extension View {
    func callToAction() -> some View {
        self
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.accent)
            .clipShape(.capsule)
    }
    
    func tappableBackground() -> some View {
        background(Color.black.opacity(0.001))
    }
    
    func removelistRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
    
    func gradientBackgroundForText() -> some View {
        self.background(
            LinearGradient(colors: [Color.black.opacity(0.1),
                                    Color.black.opacity(0.3),
                                    Color.black.opacity(0.4)],
                           startPoint: .top,
                           endPoint: .bottom)
        )
    }
}

#Preview {
    Text("Hello, World!")
        .callToAction()
}
