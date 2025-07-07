//
//  DiaryManagerTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//


import XCTest
@testable import Sentia

final class DiaryManagerTests: XCTestCase {
    var sut: DiaryManager!
    var testEntry: DiaryEntry!

    override func setUp() {
        super.setUp()
        sut = DiaryManager()
        sut.entries = [] 
        testEntry = DiaryEntry(
            emotionGroupID: UUID(),
            feelingID: UUID(),
            emotionGroup: "Raiva",
            feeling: "Irritado",
            emojiGroup: "😠",
            emojiFeeling: "😤",
            message: "Me senti mal hoje.",
            date: Date()
        )
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSave_ShouldAppendEntry() {
        sut.save(entry: testEntry)
        XCTAssertEqual(sut.entries.count, 1)
        XCTAssertEqual(sut.entries.first?.message, testEntry.message)
    }

    func testRemove_ShouldDeleteCorrectEntry() {
        sut.save(entry: testEntry)
        sut.remove(groupId: testEntry.emotionGroupID, feelingId: testEntry.feelingID)
        XCTAssertTrue(sut.entries.isEmpty)
    }

    func testAllEntries_ShouldReturnPersistedEntries() {
        sut.save(entry: testEntry)
        let all = sut.allEntries()
        XCTAssertEqual(all.count, 1)
    }
}
