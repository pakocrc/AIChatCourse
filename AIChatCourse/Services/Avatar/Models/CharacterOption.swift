//
//  CharacterOption.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 14/8/25.
//

enum CharacterOption: String, Hashable, CaseIterable {
    case man, woman, dog, cat, alien
    
    static var `default`: Self { .man }
	
	var startsWithAVowel: Bool {
		switch self.rawValue.first {
		case "a", "e", "i", "o", "u":
			return true
		default:
			return false
		}
	}
	
	var pluralized: String {
		switch self {
		case .man:
			return "men"
		case .woman:
			return "momen"
		default:
			return "\(self.rawValue)s"
		}
	}
}
