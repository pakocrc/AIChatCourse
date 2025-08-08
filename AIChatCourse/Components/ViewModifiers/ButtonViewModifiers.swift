//
//  ButtonViewModifiers.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/8/25.
//

import SwiftUI

enum ButtonStyleOption {
	case press, highlight, plain
}

struct HighlightButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.overlay {
				configuration.isPressed ? Color.accent.opacity(0.4) : Color.accent.opacity(0)
			}
			.animation(.smooth, value: configuration.isPressed)
	}
}

struct PressableButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.9 : 1.0)
			.animation(.smooth, value: configuration.isPressed)
	}
}

extension View {
	
	@ViewBuilder
	func anyButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
		switch option {
		case .press:
			self.scaleOnPress(action: action)
		case .highlight:
			self.highlightOnPress(action: action)
		case .plain:
			self.buttonStyle(PlainButtonStyle())
		}
	}
	
	private func highlightOnPress(action: @escaping () -> Void) -> some View {
		Button {
			action()
		} label: {
			self
		}
		.buttonStyle(HighlightButtonStyle())
	}
	
	private func scaleOnPress(action: @escaping () -> Void) -> some View {
		Button {
			action()
		} label: {
			self
		}
		.buttonStyle(PressableButtonStyle())
	}
}

#Preview {
	VStack(spacing: 20) {
		Text("Highlight on Press!")
			.anyButton(action: {
				
			})
		
		Text("Highlight on Press 2!")
			.frame(maxWidth: .infinity)
			.anyButton(.highlight, action: { })
		
		Text("Scale on Press 3!")
			.anyButton(.press, action: { })
		
		Text("Scale on Press 4!")
			.callToAction()
			.anyButton(.press) { }
			.padding()
	}
}
