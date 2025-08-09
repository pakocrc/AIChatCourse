//
//  SettingsView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct SettingsView: View {
	@Environment(AppState.self) private var appState
	@Environment(\.dismiss) private var dismiss
	
	@State var isPremium: Bool = false
	@State var isAnnonymousUser: Bool = true
	@State var createAccountSheetPresented: Bool = false
	
	var body: some View {
		NavigationStack {
			List {
				accountSection
				
				purchasesSection
				
				appSection
				
				signOutSection
			}
			.navigationTitle("Settings")
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						dismiss()
					} label: {
						Image(systemName: "xmark")
					}
				}
			}
			.sheet(isPresented: $createAccountSheetPresented) {
				CreateAccountView()
					.presentationDetents([.medium])
			}
		}
	}
	
	// MARK: - View Components
	private var accountSection: some View {
		Section {
			Text("Profile")
				.font(.callout)
				.fontWeight(.regular)
			
		} header: {
			Text("Account")
		}
	}
	
	private var purchasesSection: some View {
		Section {
			HStack {
				Text("Account Status")
					.font(.callout)
					.fontWeight(.regular)
				Spacer()
				Text(isPremium ? "Premium" : "Free")
					.font(.callout)
					.fontWeight(.medium)
					.foregroundStyle(.secondary)
			}
		} header: {
			Text("Purchases")
		}
	}
	
	private var appSection: some View {
		Section {
			HStack {
				Text("Version")
					.font(.callout)
					.fontWeight(.regular)
				Spacer()
				Text(Bundle.main.appVersion)
					.font(.callout)
					.foregroundStyle(.secondary)
					.fontWeight(.medium)
			}
			
			HStack {
				Text("Build Number")
					.font(.callout)
					.fontWeight(.regular)
				Spacer()
				Text(Bundle.main.buildNumber)
					.font(.callout)
					.foregroundStyle(.secondary)
					.fontWeight(.medium)
			}
			
			HStack {
				Text("Contact Support")
					.font(.callout)
					.fontWeight(.regular)
					.foregroundStyle(.accent)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
			.anyButton(.highlight) {
				
			}
			
		} header: {
			Text("App")
			
		} footer: {
			Text("@ Created by Francisco Cordoba 2025")
				.foregroundStyle(.secondary)
				.font(.caption)
				.fontWeight(.medium)
		}
	}
	
	private var signOutSection: some View {
		if isAnnonymousUser {
			Text("Sign Out")
				.foregroundStyle(.accent)
				.font(.headline)
				.fontWeight(.medium)
				.frame(maxWidth: .infinity)
				.anyButton(.press) {
					signOut()
				}
		} else {
			Text("Create Account")
				.foregroundStyle(.blue)
				.font(.headline)
				.fontWeight(.medium)
				.frame(maxWidth: .infinity)
				.anyButton(.press) {
					onCreateAccountButtonPressed()
				}
		}
	}
	
	// MARK: - Functions
	private func onCreateAccountButtonPressed() {
		createAccountSheetPresented = true
	}
	
	private func signOut() {
		dismiss()
		appState.updateViewState(showTabBar: false)
	}
}

#Preview {
	NavigationStack {
		SettingsView()
			.environment(AppState())
	}
}
