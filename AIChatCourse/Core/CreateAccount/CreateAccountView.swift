//
//  CreateAccountView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 8/8/25.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @Environment(\.dismiss) var dismiss
	var title: String = "Create Account"
	var subtitle: String = "Don't lose your data! Connect to an SSO provider to save your account information."
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?

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
            onSignInWithAppleButtonTap()
		})
		.padding()
		
		Spacer()
    }

    private func onSignInWithAppleButtonTap() {
        Task {
            do {
                let result = try await authManager.signInWithApple()
                print("[CreateAccountView] Signed in with Apple! User id: \(result.user.uid)")

                try await userManager.logIn(userAuthInfo: result.user, isNewUser: result.isNewUser)
                print("[CreateAccountView] Logged into the database! User id: \(result.user.uid)")

                onDidSignIn?(result.isNewUser)
                dismiss()

            } catch {
                print("[CreateAccountView] Error signing in with Apple. Error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
	VStack {
		CreateAccountView(
			title: "Sign In",
			subtitle: "Already have an account? Sign in instead.",
            onDidSignIn: { _ in }
		)
		
		CreateAccountView()
            .background(Color.blue)
	}
}
