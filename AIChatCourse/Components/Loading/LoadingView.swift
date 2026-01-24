//
//  LoadingView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 1/23/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(white: 0.1, opacity: 0.75)
                .ignoresSafeArea()
            ProgressView {
                Text("Loading")
            }
            .controlSize(.large)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
