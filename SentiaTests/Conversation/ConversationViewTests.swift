//
//  ConversationViewTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//


//
//  ConversationViewTests.swift
//  SentiaTests
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class ConversationViewTests: XCTestCase {
    // MARK: - Properties
    var sut: MockConversationViewModel!
    
    // MARK: - Setup & Teardown
    override func setUp() {
        super.setUp()
        sut = MockConversationViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_initialState_shouldHaveDefaultValues() {
        XCTAssertEqual(sut.emotionGroupName, "Triste")
        XCTAssertEqual(sut.emotionGroupEmoji, "😢")
        XCTAssertEqual(sut.feelingName, "Desamparado")
        XCTAssertEqual(sut.feelingEmoji, "😔")
        XCTAssertFalse(sut.isSaving)
        XCTAssertFalse(sut.showSavedLabel)
        XCTAssertNil(sut.response)
        XCTAssertNil(sut.error)
        XCTAssertNil(sut.date)
    }
    
    func test_fetchResponse_shouldSetDidCallFetchTrue() {
        XCTAssertFalse(sut.didCallFetch)
        sut.fetchResponse()
        XCTAssertTrue(sut.didCallFetch)
    }
    
    func test_saveToDiary_shouldSetDidCallSaveTrue() {
        XCTAssertFalse(sut.didCallSave)
        sut.saveToDiary()
        XCTAssertTrue(sut.didCallSave)
    }
    
    func test_responseState_whenSet_shouldUpdateValue() {
        sut.response = "Mensagem de teste"
        XCTAssertEqual(sut.response, "Mensagem de teste")
    }
    
    func test_errorState_whenSet_shouldUpdateValue() {
        sut.error = "Erro simulado"
        XCTAssertEqual(sut.error, "Erro simulado")
    }
    
    func test_loadingState_whenTrue_shouldReflectInState() {
        sut.isLoading = true
        XCTAssertTrue(sut.isLoading)
    }
    
    func test_isSavingState_whenTrue_shouldReflectInState() {
        sut.isSaving = true
        XCTAssertTrue(sut.isSaving)
    }
    
    func test_showSavedLabel_whenTrue_shouldReflectInState() {
        sut.showSavedLabel = true
        XCTAssertTrue(sut.showSavedLabel)
    }
    
    func test_dateAssignment_shouldStoreDate() {
        let now = Date()
        sut.date = now
        XCTAssertEqual(sut.date, now)
    }
}
