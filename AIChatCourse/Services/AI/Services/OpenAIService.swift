//
//  OpenAIService.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 7/23/26.
//

import SwiftUI
import OpenAI

struct OpenAIService: AIService {
    enum OpenAIError: Error {
        case invalidResponse
    }

    var openAI: OpenAI {
        OpenAI(apiToken: Keys.openAIApiKey)
    }

    func generateImage(prompt: String) async throws -> UIImage {
        let query = ImagesQuery(
            prompt: prompt,
            model: .gpt4
//            n: 1,
//            quality: .hd,
//            responseFormat: ImagesQuery.ResponseFormat.b64_json,
//            size: ._512,
//            style: ImagesQuery.Style.natural,
//            user: nil
        )

        do {
            let result = try await openAI.images(query: query)

            guard let b64Json = result.data.first?.b64Json,
                  let data = Data(base64Encoded: b64Json),
                  let image = UIImage(data: data)
            else {
                throw OpenAIError.invalidResponse
            }

            return image

        } catch {
            print("❌ Error: \(error.localizedDescription)")
            throw error
        }
    }
}
