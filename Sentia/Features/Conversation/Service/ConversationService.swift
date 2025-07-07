//
//  ConversationService.swift.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import OpenAI
import Foundation

// MARK: - ConversationServiceProtocol

/// A protocol defining an interface for sending messages to a conversation API.
protocol ConversationServiceProtocol {
    func send(prompt: String, context: String) async throws -> String
}

// MARK: - ConversationService

/// Concrete implementation of `ConversationServiceProtocol` responsible for
/// communicating with the OpenAI API.
final class ConversationService: ConversationServiceProtocol {
    private let apiKey: String
    private let networkClient: NetworkClientProtocol

    init(apiKey: String, networkClient: NetworkClientProtocol = NetworkClient()) {
        self.apiKey = apiKey
        self.networkClient = networkClient
    }

    func send(prompt: String, context: String) async throws -> String {
        let url = Constants.Conversation.apiURL

        let headers = [
            Constants.Conversation.authHeader: "Bearer \(apiKey)",
            Constants.Conversation.contentTypeHeader: Constants.Conversation.jsonType
        ]

        let body: [String: Any] = [
            "model": Constants.Conversation.model,
            "messages": [
                ["role": "system", "content": "\(Constants.Conversation.systemPromptPrefix) \(context)."],
                ["role": "user", "content": prompt]
            ],
            "temperature": Constants.Conversation.temperature,
            "max_tokens": Constants.Conversation.maxTokens
        ]

        let data = try await networkClient.post(url: url, headers: headers, body: body)
        let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        return decoded.choices.first?.message.content ?? Constants.Conversation.fallbackMessage
    }
}
