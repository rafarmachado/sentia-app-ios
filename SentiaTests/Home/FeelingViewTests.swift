//
//  FeelingViewTests.swift
//  SentiaTests
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class FeelingViewTests: XCTestCase {
    
    // Dummy data
    private var dummyFeeling: Feeling!
    
    // MARK: - Setup & Teardown
    override func setUp() {
        super.setUp()
        dummyFeeling = Feeling(name: "Happy", emoji: "😄")
    }
    
    override func tearDown() {
        dummyFeeling = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFeelingModelInitialization() {
        XCTAssertEqual(dummyFeeling.name, "Happy")
        XCTAssertEqual(dummyFeeling.emoji, "😄")
    }

    func testFeelingViewInitialization_WithSelectedTrue() {
        let view = FeelingView(feeling: dummyFeeling, isSelected: true)
        XCTAssertEqual(view.feeling.name, "Happy")
        XCTAssertTrue(view.isSelected)
    }
    
    func testFeelingViewInitialization_WithSelectedFalse() {
        let view = FeelingView(feeling: dummyFeeling, isSelected: false)
        XCTAssertEqual(view.feeling.emoji, "😄")
        XCTAssertFalse(view.isSelected)
    }
}
