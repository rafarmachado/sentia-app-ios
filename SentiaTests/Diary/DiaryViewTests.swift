//
//  DiaryViewLogicTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//


import XCTest
import Combine
@testable import Sentia

final class DiaryViewTests: XCTestCase {
    var viewModel: MockDiaryViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = MockDiaryViewModel()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testInitialEntries_AreEmpty() {
        // Given
        viewModel.entries = []

        // When
        let expectation = XCTestExpectation(description: "Entries should be empty")
        viewModel.$entries
            .sink { entries in
                if entries.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func testDeleteEntry_CallsDeleteLogic() {
        // Given
        let stubEntry = DiaryEntry.stub()
        viewModel.entries = [stubEntry]

        // When
        viewModel.deleteEntry(at: IndexSet(integer: 0))

        // Then
        XCTAssertTrue(viewModel.didCallDelete, "deleteEntry(at:) should trigger removal logic.")
    }

    func testRefreshEntries_TriggersRefreshCall() {
        // When
        viewModel.refresh()

        // Then
        XCTAssertTrue(viewModel.didCallRefresh, "refresh() should trigger refresh logic.")
    }
}


