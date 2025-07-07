//
//  MockConversationUseCase.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class MockConversationUseCase: ConversationUseCase {
    var mockedReply: String = ""
    var shouldThrow: Bool = false

    func getReply(prompt: String, context: String) async throws -> String {
        if shouldThrow {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return mockedReply
    }
}
