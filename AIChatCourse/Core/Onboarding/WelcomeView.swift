//
//  WelcomeView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @State var imageUrl = Constants.randomImageUrl
	@State var createAccountSheetPresented: Bool = false
	
    var body: some View {
        NavigationStack {
            VStack {
                ImageLoaderView(imageUrlString: imageUrl)
                    .ignoresSafeArea()
                
                titleSection
                
                middleSection
                
                bottomSection
            }
        }
		.sheet(isPresented: $createAccountSheetPresented) {
			CreateAccountView(
				title: "Sign In",
				subtitle: "Already have an account? Connect to an existing account instead."
			)
				.presentationDetents([.medium])
		}
    }
    
	// MARK: - View Components
    private var titleSection: some View {
        Text("AI Chat")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
            .accessibilityLabel(Text("Welcome to the AI Chat onboarding"))
    }
    
    private var middleSection: some View {
        NavigationLink {
            OnboardingIntroView()
        } label: {
            Text("Get started")
                .callToAction()
                .accessibilityLabel(Text("Start the onboarding process"))
                .accessibilityHint(Text("Start the onboarding process"))
        }
        .padding()
    }
    
    private var bottomSection: some View {
        VStack(spacing: 20) {
            
            Text("Already have an account? Sign in")
                .font(.headline)
                .fontWeight(.regular)
                .underline()
                .limitMaxDynamicTypeSize(dynamicTypeSize)
                .tappableBackground()
				.anyButton(.press, action: {
					onSignInPressed()
				})
                .accessibilityLabel(Text("Link to sign in page"))
                .accessibilityHint(Text("Displays the sign in page"))
            
            HStack(spacing: 10) {
                Link("Terms of Service", destination: URL(string: Constants.termsOfServiceUrl)!)
                    .font(.callout)
                    .fontWeight(.medium)
                    .limitMaxDynamicTypeSize(dynamicTypeSize)
                    .accessibilityLabel(Text("Link to terms of service page"))
                    .accessibilityHint(Text("Displays the terms of service"))
                
                Circle()
                    .fill(.accent)
                    .frame(width: 4, height: 4)
                
                Link("Privacy Policy", destination: URL(string: Constants.privacyPolicyUrl)!)
                    .font(.callout)
                    .fontWeight(.medium)
                    .limitMaxDynamicTypeSize(dynamicTypeSize)
                    .accessibilityLabel(Text("Link to privacy policy page"))
                    .accessibilityHint(Text("Displays the privacy policy"))
            }
        }
    }
	
	// MARK: - Functions
	private func onSignInPressed() {
		createAccountSheetPresented = true
	}
}

#Preview("Light") {
    NavigationStack {
        WelcomeView()
            .environment(AppState())
            .colorScheme(.light)
    }
}

#Preview("Dark") {
    NavigationStack {
        WelcomeView()
            .environment(AppState())
            .colorScheme(.dark)
    }
}
