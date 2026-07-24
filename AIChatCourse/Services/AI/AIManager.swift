//
//  AIManager.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/18/26.
//

import SwiftUI

@MainActor
@Observable
final class AIManager {
    private let service: AIService

    init(service: AIService) {
        self.service = service
    }

    func generateImage(prompt: String) async throws -> UIImage {
        try await service.generateImage(prompt: prompt)
    }
}
