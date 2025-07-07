//
//  DiaryViewModel.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import Foundation
import Combine

/// A protocol for observing and interacting with diary entries.
protocol DiaryViewModelProtocol: ObservableObject {
    var entries: [DiaryEntry] { get }
    func deleteEntry(at indexSet: IndexSet)
    func refresh()
}

/// ViewModel responsible for managing the list of diary entries.
/// It observes changes from the `DiaryManager` and keeps the list sorted by date (descending).
final class DiaryViewModel: ObservableObject, DiaryViewModelProtocol {
    // MARK: - Published Properties

    /// Sorted diary entries by most recent date.
    @Published var entries: [DiaryEntry] = []

    // MARK: - Dependencies

    private let diaryManager: DiaryManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Initializes the view model with a given diary manager.
    /// - Parameter diaryManager: The manager responsible for loading and updating diary entries.
    init(diaryManager: DiaryManagerProtocol) {
        self.diaryManager = diaryManager

        diaryManager.entriesPublisher
            .map { $0.sorted(by: { $0.date > $1.date }) }
            .receive(on: DispatchQueue.main)
            .assign(to: &$entries)
    }

    // MARK: - Public Methods

    /// Refreshes the diary entries manually by reloading them from the manager.
    func refresh() {
        entries = diaryManager.allEntries().sorted(by: { $0.date > $1.date })
    }

    /// Deletes diary entries at the given index set.
    /// - Parameter indexSet: The index set indicating the items to remove.
    func deleteEntry(at indexSet: IndexSet) {
        for index in indexSet {
            guard entries.indices.contains(index) else { continue } // Protege
            
            let entry = entries[index]
            diaryManager.remove(groupId: entry.emotionGroupID, feelingId: entry.feelingID)
        }
        entries.remove(atOffsets: indexSet)
    }
}
