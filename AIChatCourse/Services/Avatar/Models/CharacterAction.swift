//
//  CharacterAction.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 14/8/25.
//

enum CharacterAction: String, Hashable, CaseIterable {
    case smiling, sitting, eating, drinking, walking, shopping, studying, working, sleeping, relaxing, fighting, crying, laughing
    
    static var `default`: Self { .smiling }
}
