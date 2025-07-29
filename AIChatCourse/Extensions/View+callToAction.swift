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
}

#Preview {
    Text("Hello, World!")
        .callToAction()
}
