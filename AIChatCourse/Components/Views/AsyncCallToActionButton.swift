//
//  AsyncCallToActionButton.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 14/8/25.
//

import SwiftUI

struct AsyncCallToActionButton: View {
	var title: String = "Save"
	var isEnabled: Bool = true
	var isLoading: Bool = false
	var action: () -> Void
	
	var body: some View {
		ZStack {
			if isLoading {
				ProgressView()
					.tint(.white)
			} else {
				Text(title)
					.font(.headline)
					.fontWeight(.semibold)
					.frame(maxWidth: .infinity)
			}
		}
		.font(.headline)
		.fontWeight(.bold)
		.foregroundStyle(.white)
		.frame(maxWidth: .infinity)
		.frame(height: 50)
		.background(isLoading || !isEnabled ? Color.gray : Color.accent)
		.clipShape(.capsule)
		.anyButton(.press) {
			action()
		}
		.padding()
		.disabled(isLoading || !isEnabled)
	}
}

private struct PreviewView: View {
	@State var isLoading: Bool = false

	var body: some View {
		AsyncCallToActionButton(title: "Loading Test", isLoading: isLoading, action: {
			Task {
				await toggleLoading()
			}
		})
		.task {
			await toggleLoading()
		}
	}
	
	private func toggleLoading() async {
		isLoading = true
		try? await Task.sleep(for: .seconds(2))
		isLoading = false
	}
}

#Preview {
	VStack {
		AsyncCallToActionButton {
			
		}
		
		AsyncCallToActionButton(title: "Cancel", isEnabled: false) {
			
		}
		
		PreviewView()
	}
}
