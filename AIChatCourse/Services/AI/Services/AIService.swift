//
//  AIService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/23/26.
//

import SwiftUI

protocol AIService: Sendable {
    func generateImage(prompt: String) async throws -> UIImage
}
