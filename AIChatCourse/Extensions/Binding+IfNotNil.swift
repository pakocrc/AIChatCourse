//
//  Binding+IfNotNil.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 19/8/25.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
	
	init<T: Sendable>(ifNotNil value: Binding<T?>) {
		self.init {
			value.wrappedValue != nil
		} set: { newValue in
			if !newValue {
				value.wrappedValue = nil
			}
		}
	}
}
