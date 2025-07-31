//
//  OnboardingColorView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 30/7/25.
//

import SwiftUI

struct OnboardingColorView: View {
    
    @State private var selectedColor: Color?
    
    private let gridColums: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 3)
    private let colors: [Color] = [
        .green,
        .blue,
        .indigo,
        .red,
        .orange,
        .yellow,
        .purple,
        .pink,
        .brown
    ]
    
    var body: some View {
        ScrollView {
            colorsGrid
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 16, content: {
            bottomSection
        })
        .navigationBarBackButtonHidden()
        .animation(.smooth, value: selectedColor)
    }
    
    private var colorsGrid: some View {
        LazyVGrid(columns: gridColums,
                  alignment: .center,
                  spacing: 20,
                  pinnedViews: [.sectionHeaders],
                  content: {
            Section(header:
                        Text("Select a profile color")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.primary)
            ) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .overlay(
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: selectedColor == color ? 7 : 0))
                                .foregroundStyle(Color.accentColor)
                        )
                        .foregroundColor(color)
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
        })
        .padding()
    }
    
    private var bottomSection: some View {
        ZStack {
            if selectedColor != nil {
                NavigationLink {
                    OnboardingCompletedView(selectedColor: selectedColor)
                } label: {
                    Text("Continue")
                        .callToAction()
                        .accessibilityLabel(Text("Continue the onboarding process"))
                        .accessibilityHint(Text("Continue the onboarding process"))
                }
                .disabled(selectedColor == nil)
                .transition(AnyTransition.move(edge: .bottom))
                .padding()
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}

#Preview("Light") {
    NavigationStack {
        OnboardingColorView()
            .colorScheme(.light)
    }
    .environment(AppState())
}

#Preview("Dark") {
    NavigationStack {
        OnboardingColorView()
            .colorScheme(.dark)
    }
    .environment(AppState())
}
