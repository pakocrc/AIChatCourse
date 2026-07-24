//
//  MockAIService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/23/26.
//

import SwiftUI

struct MockAIService: AIService {
    func generateImage(prompt: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(2))
        return UIImage(systemName: "star.fill")!
    }
}
