//
//  DiaryViewModelTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import XCTest
@testable import Sentia

final class DiaryViewModelTests: XCTestCase {
    var sut: DiaryViewModel!
    var mockManager: MockDiaryManager!

    override func setUp() {
        super.setUp()
        mockManager = MockDiaryManager()
        sut = DiaryViewModel(diaryManager: mockManager)
    }

    override func tearDown() {
        sut = nil
        mockManager = nil
        super.tearDown()
    }

    func testInitialization_SortsEntriesDescendingByDate() {
        let dates = sut.entries.map { $0.date }
        XCTAssertEqual(dates, dates.sorted(by: >))
    }

    func testRefresh_UpdatesEntries() {
        let newEntry = DiaryEntry.stub(date: Date().addingTimeInterval(1000))
        mockManager.entries = [newEntry]

        sut.refresh()

        XCTAssertEqual(sut.entries.first?.date, newEntry.date)
    }

    func testDeleteEntry_RemovesCorrectEntry() {
        // Given
        let mockEntry = DiaryEntry.stub(date: Date())
        sut.entries = [mockEntry]
        let initialCount = sut.entries.count

        // When
        sut.deleteEntry(at: IndexSet(integer: 0))

        // Then
        XCTAssertLessThan(sut.entries.count, initialCount)
        XCTAssertTrue(mockManager.didCallRemove)
    }
}
