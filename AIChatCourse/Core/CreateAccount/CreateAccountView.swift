//
//  CreateAccountView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 8/8/25.
//

import SwiftUI

struct CreateAccountView: View {
	var title: String = "Create Account"
	var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account information."
	
    var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text(title)
				.font(.largeTitle)
				.fontWeight(.bold)
			
			Text(subtitle)
				.font(.title3)
				.fontWeight(.regular)
		}
		.frame(maxWidth: .infinity)
		.padding()
		.padding(.top)
		
		SignInWithAppleButtonView(
			type: .signIn,
			style: .black,
			cornerRadius: 15
		)
		.frame(height: 50)
		.anyButton(.press, action: {
			
		})
		.padding()
		
		Spacer()
    }
}

#Preview {
	VStack {
		CreateAccountView(
			title: "Sign In",
			subtitle: "Already have an account? Sign in instead."
		)
		
		CreateAccountView()
		
	}
	.background(Color.blue)
}
