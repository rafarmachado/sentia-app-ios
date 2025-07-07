//
//  MainFlowFactoryTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import Combine
import XCTest
@testable import Sentia

final class MainFlowFactoryTests: XCTestCase {

    // MARK: - Mock DiaryManager

    class MockDiaryManager: DiaryManagerProtocol {
        var entriesPublisher: Published<[DiaryEntry]>.Publisher {
            Just([]).eraseToAnyPublisher() as! Published<[DiaryEntry]>.Publisher
        }

        func save(entry: DiaryEntry) {}
        func remove(groupId: UUID, feelingId: UUID) {}
        func allEntries() -> [DiaryEntry] { return [] }
    }

    // MARK: - Test Make Conversation View

    func testMakeConversationView_returnsValidView() {
        let mockManager = MockDiaryManager()
        let feeling = Feeling(name: "Excited", emoji: "🔥")
        let group = EmotionGroup(name: "Happy", emoji: "😀", feelings: [feeling])

        let view = MainFlowFactory.makeConversationView(
            group: group,
            feeling: feeling,
            diaryManager: mockManager
        )

        XCTAssertNotNil(view)
    }
}
