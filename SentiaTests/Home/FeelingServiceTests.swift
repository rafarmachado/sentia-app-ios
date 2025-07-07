//
//  FeelingServiceTests.swift
//  SentiaTests
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class FeelingServiceTests: XCTestCase {
    var sut: FeelingServiceProtocol!

    override func setUp() {
        super.setUp()
        sut = MockFeelingService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadEmotionGroups_ReturnsValidGroups() throws {
        // When
        let groups = try sut.loadEmotionGroups()

        // Then
        XCTAssertFalse(groups.isEmpty, "Emotion groups should not be empty.")
        XCTAssertEqual(groups.first?.name, "Triste")
        XCTAssertEqual(groups.first?.emoji, "😢")
        XCTAssertEqual(groups.first?.feelings.count, 2)
        XCTAssertEqual(groups.first?.feelings.first?.name, "Desamparado")
        XCTAssertEqual(groups.first?.feelings.first?.emoji, "😔")
    }

    func testLoadEmotionGroups_ThrowsError_WhenInvalidJSON() {
        // Given
        let invalidService = BrokenMockFeelingService()

        // Then
        XCTAssertThrowsError(try invalidService.loadEmotionGroups())
    }
}
