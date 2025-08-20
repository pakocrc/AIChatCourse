//
//  View+ShowCustomAlert.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 19/8/25.
//

import SwiftUI

enum AlertType {
	case alert, confirmationDialog
}

extension View {
	@ViewBuilder
	func showCustomAlert(type: AlertType, alertInfo: Binding<AnyAppAlert?>) -> some View {
		
		switch type {
		case .alert:
			self
				.alert(alertInfo.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alertInfo)) {
					alertInfo.wrappedValue?.buttons()
				} message: {
					Text(alertInfo.wrappedValue?.message ?? "")
				}
		case .confirmationDialog:
			self
				.confirmationDialog(alertInfo.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alertInfo)) {
					alertInfo.wrappedValue?.buttons()
				} message: {
					Text(alertInfo.wrappedValue?.message ?? "")
				}
		}
	}
}
