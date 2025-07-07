//
//  DefaultConversationUseCase.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 06/07/25.
//

protocol ConversationUseCase {
    func getReply(prompt: String, context: String) async throws -> String
}

final class DefaultConversationUseCase: ConversationUseCase {
    private let service: ConversationServiceProtocol

    init(service: ConversationServiceProtocol) {
        self.service = service
    }

    func getReply(prompt: String, context: String) async throws -> String {
        try await service.send(prompt: prompt, context: context)
    }
}
