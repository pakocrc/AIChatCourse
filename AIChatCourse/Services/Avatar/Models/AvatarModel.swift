//
//  AvatarModel.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 31/7/25.
//

import Foundation

struct AvatarModel {
    let avatarId: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageUrlString: String?
    let authorId: String?
    let dateCreated: Date?
    var characterDescription: CharacterDescriptionBuilder?
    
    init(
        avatarId: String,
        name: String?,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageUrlString: String?,
        authorId: String?,
        dateCreated: Date?
    ) {
        self.avatarId = avatarId
        self.name = name
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageUrlString = profileImageUrlString
        self.authorId = authorId
        self.dateCreated = dateCreated
        self.characterDescription = CharacterDescriptionBuilder(
            characterOption: characterOption ?? .default,
            characterAction: characterAction ?? .default,
            characterLocation: characterLocation ?? .default
        )
    }
    
    static var mock: AvatarModel {
        mocks.first!
    }
    
    static var mocks: [AvatarModel] {
        [
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Alpha",
                characterOption: .alien,
                characterAction: .drinking,
                characterLocation: .beach,
                profileImageUrlString: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Beta",
                characterOption: .woman,
                characterAction: .crying,
                characterLocation: .city,
                profileImageUrlString: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Gamma",
                characterOption: .cat,
                characterAction: .sleeping,
                characterLocation: .mountain,
                profileImageUrlString: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                dateCreated: .now
            ),
            AvatarModel(
                avatarId: UUID().uuidString,
                name: "Delta",
                characterOption: .dog,
                characterAction: .walking,
                characterLocation: .forest,
                profileImageUrlString: Constants.randomImageUrl,
                authorId: UUID().uuidString,
                dateCreated: .now
            )
        ]
    }
}

extension AvatarModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(avatarId)
    }
    
    static func == (lhs: AvatarModel, rhs: AvatarModel) -> Bool {
        return lhs.avatarId == rhs.avatarId
    }
}

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
}

enum CharacterAction: String {
    case smiling, sitting, eating, drinking, walking, shopping, studying, working, sleeping, relaxing, fighting, crying, laughing
    
    static var `default`: Self { .smiling }
}

enum CharacterLocation: String {
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
