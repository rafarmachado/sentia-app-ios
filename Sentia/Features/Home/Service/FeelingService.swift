//
//  FeelingService.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import Foundation

/// Protocol defining the service responsible for loading emotion groups.
protocol FeelingServiceProtocol {
    func loadEmotionGroups() throws -> [EmotionGroup]
}

/// Concrete implementation of `FeelingServiceProtocol`
/// Loads a list of emotion groups from a local JSON file bundled in the app.
final class FeelingService: FeelingServiceProtocol {
    func loadEmotionGroups() throws -> [EmotionGroup] {
        guard let url = Bundle.main.url(forResource: Constants.Services.feelingJsonName,
                                        withExtension: Constants.Services.feelingExtension) else {
            throw NSError(
                domain: Constants.Services.domainError,
                code: Constants.Services.code,
                userInfo: [NSLocalizedDescriptionKey: Constants.Services.message]
            )
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([EmotionGroup].self, from: data)
    }
}
