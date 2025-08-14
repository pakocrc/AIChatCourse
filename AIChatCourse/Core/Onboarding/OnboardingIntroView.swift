//
//  OnboardingIntroView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 30/7/25.
//

import SwiftUI

struct OnboardingIntroView: View {
    // Accesibility Dynamic Type Size
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    var body: some View {
        VStack {
            topSection
            
            bottomSection
        }
        .navigationBarBackButtonHidden()
    }
    
    private var topSection: some View {
        VStack(spacing: 25) {
            Text("Make your own ")
                .font(.title2)
                .fontWeight(.regular)
                .foregroundStyle(.primary)
            +
            Text("avatars ")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
            +
            Text("and chat with them!\n\n")
                .font(.title2)
                .fontWeight(.regular)
                .foregroundStyle(.primary)
            +
            Text("Have ")
                .font(.title2)
                .fontWeight(.regular)
                .foregroundStyle(.primary)
            +
            Text("real conversations ")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
            +
            Text("with AI generated responses.")
                .font(.title2)
                .fontWeight(.regular)
                .foregroundStyle(.primary)
        }
        .limitMaxDynamicTypeSize(dynamicTypeSize)
        .frame(maxHeight: .infinity)
		.padding()
    }
    
    private var bottomSection: some View {
        NavigationLink {
            OnboardingColorView()
        } label: {
            Text("Continue")
                .callToAction()
                .accessibilityLabel(Text("Continue the onboarding process"))
                .accessibilityHint(Text("Continue the onboarding process"))
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        OnboardingIntroView()
    }
}
