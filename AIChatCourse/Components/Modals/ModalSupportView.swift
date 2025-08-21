//
//  ModalSupportView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 20/8/25.
//

import SwiftUI

struct ModalSupportView<Content: View>: View {
	@Binding var showModal: Bool
	@ViewBuilder var content: Content
	
    var body: some View {
		ZStack {
			if showModal {
				Color.black
					.opacity(0.7)
					.ignoresSafeArea()
					.transition(AnyTransition.opacity.animation(.smooth))
					.onTapGesture {
						showModal = false
					}
					.zIndex(1)
				
				content
					.ignoresSafeArea()
					.zIndex(10)
			}
		}
		.animation(.spring, value: showModal)
    }
}

extension View {
	func showModal(showModal: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
		self
			.overlay(
				ModalSupportView(showModal: showModal, content: content)
			)
	}
}

#Preview {
	ModalSupportView(showModal: .constant(true)) {
		
		ProfileModalView(avatar: AvatarModel.mock) {
			
		}
		.padding()
		.transition(AnyTransition.move(edge: .top).combined(with: .opacity))
	}
}
