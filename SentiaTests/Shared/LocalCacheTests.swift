//
//  LocalCacheTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//


import XCTest
@testable import Sentia

final class LocalCacheTests: XCTestCase {
    var sut: LocalCache<DiaryEntry>!

    override func setUp() {
        super.setUp()
        sut = LocalCache(fileName: "test_diary_entries")
        sut.clear()
    }

    override func tearDown() {
        sut.clear()
        sut = nil
        super.tearDown()
    }

    func testSaveAndLoad_ShouldPersistCorrectly() {
        let entry = DiaryEntry(
            emotionGroupID: UUID(),
            feelingID: UUID(),
            emotionGroup: "Triste",
            feeling: "Desamparado",
            emojiGroup: "😢",
            emojiFeeling: "😔",
            message: "Mensagem de teste",
            date: Date()
        )

        sut.save([entry])
        sleep(1) // Espera para escrita assíncrona
        let result = sut.load()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.message, "Mensagem de teste")
    }

    func testClear_ShouldRemoveFile() {
        sut.save([DiaryEntry(
            emotionGroupID: UUID(),
            feelingID: UUID(),
            emotionGroup: "Alegria",
            feeling: "Feliz",
            emojiGroup: "😊",
            emojiFeeling: "😄",
            message: "Exemplo",
            date: Date()
        )])
        sleep(1)
        sut.clear()
        let result = sut.load()
        XCTAssertTrue(result.isEmpty)
    }
}