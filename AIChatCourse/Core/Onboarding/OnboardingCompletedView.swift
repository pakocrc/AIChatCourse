//
//  OnboardingCompletedView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var appState
    @Environment(UserManager.self) private var userManager

    @State private var isCompletingProfileSetup: Bool = false
    @State private var presentAlert: AnyAppAlert?

    let selectedColor: Color

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
                .foregroundStyle(selectedColor)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("We've set up everything for you to start chatting!")
                .foregroundStyle(.secondary)
                .font(.title)
                .fontWeight(.medium)
        }
        .showCustomAlert(type: .alert, alertInfo: $presentAlert)
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
            do {
                let hexColor = selectedColor.asHex()
                try await userManager.markOnboardingComplete(profileColorHex: hexColor)

                // Dismiss screen
                isCompletingProfileSetup = false
                appState.updateViewState(showTabBar: true)

            } catch let error {
                presentAlert = AnyAppAlert(error: error)
            }
        }
    }
}

#Preview {
    OnboardingCompletedView(selectedColor: Color.green)
        .environment(AppState())
        .environment(UserManager(userServices: MockUserServices(user: .mock)))
}
