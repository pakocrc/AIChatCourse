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
            Text("Explore")
                .navigationTitle("Explore")

            NavigationLink("Navigate", destination: Text("Navigate"))
        }
    }
}

#Preview {
    ExploreView()
}
