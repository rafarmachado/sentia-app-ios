//
//  MockDiaryManager.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import Foundation
import Combine
@testable import Sentia

final class MockDiaryManager: DiaryManagerProtocol {
    // MARK: - Properties

    @Published var entries: [DiaryEntry] = [
        DiaryEntry.stub(date: Date()),
        DiaryEntry.stub(date: Date().addingTimeInterval(-1000))
    ]

    var didCallRemove = false
    var didCallSave = false
    var savedEntry: DiaryEntry?

    // MARK: - Protocol Conformance

    var entriesPublisher: Published<[DiaryEntry]>.Publisher { $entries }

    func save(entry: DiaryEntry) {
        didCallSave = true
        savedEntry = entry
        entries.append(entry)
    }

    func remove(groupId: UUID, feelingId: UUID) {
        didCallRemove = true
        entries.removeAll {
            $0.emotionGroupID == groupId && $0.feelingID == feelingId
        }
    }

    func allEntries() -> [DiaryEntry] {
        return entries
    }
}


extension DiaryEntry {
    static func stub(
        emotionGroupID: UUID = UUID(),
        feelingID: UUID = UUID(),
        emotionGroup: String = "Triste",
        feeling: String = "Desamparado",
        emojiGroup: String = "😢",
        emojiFeeling: String = "😔",
        message: String = "Mensagem de exemplo",
        date: Date = Date()
    ) -> DiaryEntry {
        return DiaryEntry(
            emotionGroupID: emotionGroupID,
            feelingID: feelingID,
            emotionGroup: emotionGroup,
            feeling: feeling,
            emojiGroup: emojiGroup,
            emojiFeeling: emojiFeeling,
            message: message,
            date: date
        )
    }
}
