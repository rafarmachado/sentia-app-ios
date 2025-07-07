//
//  RootCoordinatorViewModel.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import Foundation
import Combine

final class RootCoordinatorViewModel: ObservableObject {
    @Published var showSplash: Bool = true
    private var cancellables = Set<AnyCancellable>()

    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.showSplash = false
        }
    }
}
