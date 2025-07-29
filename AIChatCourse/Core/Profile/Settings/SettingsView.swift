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

    var body: some View {
        NavigationStack {
            List {
                Text("Settings")

                Button {
                    signOut()
                } label: {
                    Text(String(localized: "Sign Out"))
                }
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
        }
    }

    private func signOut() {
        appState.updateViewState(showTabBar: false)
    }
}

#Preview {
    SettingsView()
}
