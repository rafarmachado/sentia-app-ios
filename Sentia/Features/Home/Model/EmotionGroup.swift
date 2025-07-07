//
//  EmotionGroup.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import Foundation

/// Model representing a group of related emotions.
struct EmotionGroup: Identifiable, Codable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let emoji: String
    let feelings: [Feeling]
}
