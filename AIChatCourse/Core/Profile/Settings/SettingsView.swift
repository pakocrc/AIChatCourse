//
//  SettingsView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 29/7/25.
//

import SwiftUI

struct SettingsView: View {
	@Environment(AppState.self) private var appState
    @Environment(AuthManager.self) private var authManager
	@Environment(\.dismiss) private var dismiss

	@State var isPremium: Bool = false
	@State var isAnnonymousUser: Bool = true
	@State var createAccountSheetPresented: Bool = false
    @State var showAlert: AnyAppAlert?

	var body: some View {
		NavigationStack {
			List {
                if !isAnnonymousUser {
                    accountSection
                }

				purchasesSection
				
				appSection
				
				signOutSection
			}
			.navigationTitle("Settings")
            .showCustomAlert(type: .alert, alertInfo: $showAlert)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						dismiss()
					} label: {
						Image(systemName: "xmark")
					}
				}
			}
            .sheet(isPresented: $createAccountSheetPresented, onDismiss: {
                setAnnonymousAccountStatus()
            }, content: {
                CreateAccountView()
                    .presentationDetents(
                        [.medium]
                    )
            })
            .onAppear {
                setAnnonymousAccountStatus()
            }
		}
	}
	
	// MARK: - View Components
	private var accountSection: some View {
		Section {
            Text("Profile")
                .anyButton {

                }

            Text("Delete Account")
                .anyButton {
                    onDeleteUserPressed()
                }

		} header: {
			Text("Account")
		}
	}
	
	private var purchasesSection: some View {
		Section {
			HStack {
				Text("Account Status")
				Spacer()
				Text(isPremium ? "Premium" : "Free")
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
				Spacer()
                Text(Utilities.appVersion)
					.foregroundStyle(.secondary)
					.fontWeight(.medium)
			}
			
			HStack {
				Text("Build Number")
				Spacer()
				Text(Bundle.main.buildNumber)
					.foregroundStyle(.secondary)
					.fontWeight(.medium)
			}
			
			HStack {
				Text("Contact Support")
					.frame(maxWidth: .infinity, alignment: .leading)
			}
			.anyButton(.highlight) {
				
			}
			
		} header: {
			Text("App")
			
		} footer: {
			Text("@ Created by Francisco Cordoba, 2025")
                .font(.system(size: 12, weight: .light, design: .serif))
                .italic()
				.fontWeight(.medium)
		}
	}
	
    private var signOutSection: some View {
        if isAnnonymousUser {
            Text("Create Account")
                .foregroundStyle(.blue)
                .font(.headline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .anyButton(.press) {
                    onCreateAccountButtonPressed()
                }
        } else {
            Text("Sign Out")
                .foregroundStyle(.accent)
                .font(.headline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .anyButton(.press) {
                    onSignOutPressed()
                }
        }
    }
	
	// MARK: - Functions
	private func onCreateAccountButtonPressed() {
		createAccountSheetPresented = true
	}

    private func setAnnonymousAccountStatus() {
        print("[SettingsView] User: \(authManager.userAuth?.uid ?? "no user")")

        guard let isAnonymous = authManager.userAuth?.isAnonymous, !isAnonymous else {
            isAnnonymousUser = true
            return
        }

        isAnnonymousUser = false
    }

	private func onSignOutPressed() {
        do {
            try authManager.signOut()
            print("[SettingsView] Signed out successfully!")
            dismissScreen()

        } catch {
            print("[SettingsView] Error signing out: \(error.localizedDescription)")
            showAlert = AnyAppAlert(error: error)
        }
	}

    private func onDeleteUserPressed() {
        showAlert = AnyAppAlert(
            title: "Warning",
            message: "This action cannot be undone. Are you sure you want to delete your account?",
            buttons: {
                AnyView(
                    Button("Delete", role: .destructive) {
                        deleteUserConfirmed()
                    }
                )
            }
        )
    }

    private func deleteUserConfirmed() {
        Task {
            do {
                try await authManager.deleteAccount()
                print("[SettingsView] Account deleted successfully!")

                dismissScreen()

            } catch {
                print("[SettingsView] Error deleting account: \(error.localizedDescription)")
                showAlert = AnyAppAlert(error: error)
            }
        }
    }

    private func dismissScreen() {
        dismiss()
        appState.updateViewState(showTabBar: false)
    }
}

#Preview("Signed in") {
	NavigationStack {
		SettingsView()
            .environment(AuthManager(service: MockAuthService(currentUser: UserAuthInfo.mock(isAnonymous: false))))
			.environment(AppState())
	}
}

#Preview("Anonymous") {
    NavigationStack {
        SettingsView()
            .environment(AuthManager(service: MockAuthService(currentUser: UserAuthInfo.mock(isAnonymous: true))))
            .environment(AppState())
    }
}

#Preview("Not Auth") {
    NavigationStack {
        SettingsView()
            .environment(AuthManager(service: MockAuthService(currentUser: nil)))
            .environment(AppState())
    }
}
