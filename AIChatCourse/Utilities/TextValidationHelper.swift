//
//  TextValidationHelper.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 19/8/25.
//

import Foundation
import SwiftUI

struct TextValidationHelper {
	enum TextValidationError: String, LocalizedError {
		case notEnoughCharacters = "Not enough characters"
		case hasBadWords = "Bad Words"
		
		var errorDescription: String? {
			switch self {
			case .notEnoughCharacters:
				"Please add more characters to the prompt"
			case .hasBadWords:
				"Please avoid the use of bad words"
			}
		}
	}
	
	static func validateTextFieldText(text: String) throws {
		let badWords = ["shit", "bitch", "ass"]
		
		if text.count <= 3 {
			throw TextValidationError.notEnoughCharacters
		}
		
		if badWords.contains(text.lowercased()) {
			throw TextValidationError.hasBadWords
		}
	}
}
