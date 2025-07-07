//
//  LoadAPIKey.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//
import Foundation

// MARK: - LoadAPIKey

/// Utility responsible for loading secrets from a .plist file.
final class LoadAPIKey {
    func loadAPIKey() -> String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let dict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
            let key = dict["OPENAI_API_KEY"] as? String
        else {
            fatalError("\(Constants.Errors.apiKeyLoadFailure)")
        }

        return key
    }
}
