//
//  ConversationViewModelTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import XCTest
@testable import Sentia

final class ConversationViewModelTests: XCTestCase {
    var sut: ConversationViewModel!
    var mockUseCase: MockConversationUseCase!
    var mockDiaryManager: MockDiaryManager!

    override func setUp() {
        super.setUp()
        mockUseCase = MockConversationUseCase()
        mockDiaryManager = MockDiaryManager()
        
        sut = ConversationViewModel(
            emotionalGroup: EmotionGroup(name: "Triste", emoji: "😢", feelings: []),
            feeling: Feeling(name: "Desamparado", emoji: "😔"),
            useCase: mockUseCase,
            diaryManager: mockDiaryManager
        )
    }

    override func tearDown() {
        sut = nil
        mockUseCase = nil
        mockDiaryManager = nil
        super.tearDown()
    }

    func test_fetchResponse_success() {
        mockUseCase.mockedReply = "Você está se sentindo compreendido."
        
        sut.fetchResponse()
        
        // Aguarde resposta usando expectation
        let expectation = XCTestExpectation(description: "Wait for response")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertEqual(self.sut.response, "Você está se sentindo compreendido.")
            XCTAssertNil(self.sut.error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func test_fetchResponse_failure() {
        // Given
        mockUseCase.shouldThrow = true
        let expectation = expectation(description: "Wait for error response")

        // When
        sut.fetchResponse()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Then
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertNil(self.sut.response)
            XCTAssertNotNil(self.sut.error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_saveToDiary_savesEntry() {
        sut.response = "Mensagem exemplo"
        sut.date = Date()

        sut.saveToDiary()

        XCTAssertTrue(mockDiaryManager.didCallSave)
        XCTAssertEqual(mockDiaryManager.savedEntry?.message, "Mensagem exemplo")
    }
}
