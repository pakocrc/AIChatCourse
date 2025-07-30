//
//  WelcomeView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var imageUrl = Constants.randomImageUrl
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageLoaderView(imageUrlString: imageUrl)
                    .ignoresSafeArea()
                
                middleSection
                
                bottomSection
            }
        }
    }
    
    private var middleSection: some View {
        Text("AI Chat")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
    }
    
    private var bottomSection: some View {
        VStack(spacing: 20) {
            
            NavigationLink {
                OnboardingCompletedView()
            } label: {
                Text("Get started")
                    .callToAction()
            }
            .padding()
            
            Text("Already have an account? Sign in")
                .font(.headline)
                .fontWeight(.regular)
                .underline()
            
            HStack(spacing: 10) {
                Link("Terms of Service", destination: URL(string: Constants.termsOfServiceUrl)!)
                    .font(.callout)
                    .fontWeight(.medium)
                
                Circle()
                    .fill(.accent)
                    .frame(width: 4, height: 4)
                
                Link("Privacy Policy", destination: URL(string: Constants.privacyPolicyUrl)!)
                    .font(.callout)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview("Light") {
    WelcomeView()
        .environment(AppState())
        .colorScheme(.light)
}

#Preview("Dark") {
    WelcomeView()
        .environment(AppState())
        .colorScheme(.dark)
}
