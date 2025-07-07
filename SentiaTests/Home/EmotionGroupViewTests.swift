//
//  EmotionGroupViewTests.swift
//  SentiaTests
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class EmotionGroupViewTests: XCTestCase {

    private var dummyGroup: EmotionGroup!

    override func setUp() {
        super.setUp()
        dummyGroup = EmotionGroup(name: "Triste", emoji: "😢", feelings: [])
    }

    override func tearDown() {
        dummyGroup = nil
        super.tearDown()
    }

    func testEmotionGroupModelInitialization() {
        XCTAssertEqual(dummyGroup.name, "Triste")
        XCTAssertEqual(dummyGroup.emoji, "😢")
        XCTAssertEqual(dummyGroup.feelings.count, 0)
    }

    func testEmotionGroupViewSelectedTrue() {
        let view = EmotionGroupView(group: dummyGroup, isSelected: true)
        XCTAssertEqual(view.group.name, "Triste")
        XCTAssertTrue(view.isSelected)
    }

    func testEmotionGroupViewSelectedFalse() {
        let view = EmotionGroupView(group: dummyGroup, isSelected: false)
        XCTAssertEqual(view.group.emoji, "😢")
        XCTAssertFalse(view.isSelected)
    }
}
