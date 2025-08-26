//
//  NavigationPathOption.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 26/8/25.
//

import Foundation
import SwiftUI

enum NavigationPathOption: Hashable {
	case chat(avatar: AvatarModel)
	case category(category: CharacterOption)
}

extension View {
	func navigationDestinationForCoreModule(path: Binding<[NavigationPathOption]>) -> some View {
		self
			.navigationDestination(for: NavigationPathOption.self) { newValue in
				switch newValue {
				case .chat(let avatar):
					ChatView(avatar: avatar)
				case .category(let category):
					CategoryListView(category: category, path: path)
				}
			}
	}
}
