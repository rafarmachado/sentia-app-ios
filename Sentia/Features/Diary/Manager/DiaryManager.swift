//
//  DiaryManager.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 04/07/25.
//

// MARK: - DiaryManager.swift
import Foundation
import Combine

/// Protocol for diary entry storage and observation.
protocol DiaryManagerProtocol: AnyObject {
    var entriesPublisher: Published<[DiaryEntry]>.Publisher { get }
    func save(entry: DiaryEntry)
    func remove(groupId: UUID, feelingId: UUID)
    func allEntries() -> [DiaryEntry]
}

/// Concrete diary manager that persists and publishes diary entries.
final class DiaryManager: ObservableObject, DiaryManagerProtocol {
    static let shared = DiaryManager()

    @Published var entries: [DiaryEntry] = []
    private let cache: LocalCache<DiaryEntry>

    var entriesPublisher: Published<[DiaryEntry]>.Publisher { $entries }

    init() {
        self.cache = LocalCache(fileName: Constants.Cache.diaryEntriesFile)
        self.entries = cache.load()
    }

    func save(entry: DiaryEntry) {
        entries.append(entry)
        cache.save(entries)
    }

    func remove(groupId: UUID, feelingId: UUID) {
        entries.removeAll {
            $0.emotionGroupID == groupId && $0.feelingID == feelingId
        }
        cache.save(entries)
    }

    func allEntries() -> [DiaryEntry] {
        return entries
    }
}
