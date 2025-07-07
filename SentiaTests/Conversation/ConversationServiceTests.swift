//
//  ConversationServiceTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//


//
//  ConversationServiceTests.swift
//  SentiaTests
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class ConversationServiceTests: XCTestCase {

    // MARK: - Properties

    private var sut: ConversationService!
    private var mockNetworkClient: MockNetworkClient!

    private let dummyAPIKey = "dummy-key"

    // MARK: - Setup / Teardown

    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        sut = ConversationService(apiKey: dummyAPIKey, networkClient: mockNetworkClient)
    }

    override func tearDown() {
        sut = nil
        mockNetworkClient = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_send_returnsExpectedContent_onValidResponse() async throws {
        // Given
        let expectedMessage = "Olá, você vai ficar bem."
        let mockJSON = """
        {
          "choices": [
            {
              "message": {
                "role": "assistant",
                "content": "\(expectedMessage)"
              }
            }
          ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.result = .success(mockJSON)

        // When
        let response = try await sut.send(prompt: "Estou triste", context: "Tristeza")

        // Then
        XCTAssertEqual(response, expectedMessage)
    }

    func test_send_returnsFallback_onMissingContent() async throws {
        // Given
        let mockJSON = """
        {
          "choices": [
            {
              "message": {
                "role": "assistant"
              }
            }
          ]
        }
        """.data(using: .utf8)!
        mockNetworkClient.result = .success(mockJSON)

        // When
        let response = try await sut.send(prompt: "Estou cansado", context: "Exaustão")

        // Then
        XCTAssertEqual(response, Constants.Conversation.fallbackMessage)
    }

    func test_send_throwsError_onNetworkFailure() async {
        // Given
        mockNetworkClient.result = .failure(URLError(.notConnectedToInternet))

        // Then
        await XCTAssertThrowsErrorAsync {
            _ = try await self.sut.send(prompt: "Estou ansioso", context: "Ansiedade")
        }
    }

    func test_send_throwsError_onInvalidJSON() async {
        // Given
        let invalidJSON = "not json".data(using: .utf8)!
        mockNetworkClient.result = .success(invalidJSON)

        // Then
        await XCTAssertThrowsErrorAsync {
            _ = try await self.sut.send(prompt: "Estou com medo", context: "Medo")
        }
    }
    
    func XCTAssertThrowsErrorAsync(_ expression: @escaping () async throws -> Void, file: StaticString = #file, line: UInt = #line) async {
        do {
            try await expression()
            XCTFail("Expected error but got none", file: file, line: line)
        } catch {
            // Success
        }
    }
}
