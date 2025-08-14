//
//  CharacterLocation.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 14/8/25.
//

enum CharacterLocation: String, Hashable, CaseIterable {
    case beach, forest, city, mountain, desert, space
    
    static var `default`: Self { .beach }
}

struct CharacterDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation
    
    var characterDescription: String {
		let prefix = characterOption.startsWithAVowel ? "An" : "A"
        return "\(prefix) \(characterOption.rawValue) \(characterAction.rawValue) at the \(characterLocation.rawValue)."
    }
}
