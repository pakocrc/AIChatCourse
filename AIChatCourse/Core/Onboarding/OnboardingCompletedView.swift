//
//  OnboardingCompletedView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        VStack {
            Text("Onboarding completed!")
                .frame(maxHeight: .infinity)
            Button {
                onFinishButtonPressed()
            } label: {
                Text("Finish")
                    .callToAction()
            }
            .padding()
        }
    }

    func onFinishButtonPressed() {
        appState.updateViewState(showTabBar: true)
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
