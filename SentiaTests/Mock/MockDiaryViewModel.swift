//
//  MockDiaryViewModel.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

// MARK: - Mock ViewModel

final class MockDiaryViewModel: DiaryViewModelProtocol {
    @Published var entries: [DiaryEntry] = []

    var didCallDelete = false
    var didCallRefresh = false

    func deleteEntry(at indexSet: IndexSet) {
        didCallDelete = true
        entries.remove(atOffsets: indexSet)
    }

    func refresh() {
        didCallRefresh = true
    }
}
