//
//  OnboardingCompletedView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var appState
    @State private var isCompletingProfileSetup: Bool = false
    var selectedColor: Color?
    
    var body: some View {
        Group {
            topSection
            
            bottomSection
        }
        .navigationBarBackButtonHidden()
    }
    
    private var topSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Setup complete!")
                .foregroundStyle(selectedColor != nil ? selectedColor! : .primary)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("We've set up everything for you to start chatting!")
                .foregroundStyle(.secondary)
                .font(.title)
                .fontWeight(.medium)
        }
        .baselineOffset(5)
        .padding()
        .frame(maxHeight: .infinity)
    }
    
    private var bottomSection: some View {
		AsyncCallToActionButton(title: "Finish") {
			onFinishButtonPressed()
		}
		.accessibilityLabel(Text("Finish the onboarding"))
		.accessibilityHint(Text("Go to the main app"))
    }
    
    private func onFinishButtonPressed() {
        isCompletingProfileSetup = true
        
        Task {
            try await Task.sleep(for: .seconds(1))

            isCompletingProfileSetup = false
            
            appState.updateViewState(showTabBar: true)
        }
    }
}

#Preview {
    OnboardingCompletedView(selectedColor: Color.green)
        .environment(AppState())
}
