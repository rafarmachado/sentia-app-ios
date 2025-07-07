//
//  Feeling.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import Foundation

/// Model representing a specific emotional state.
struct Feeling: Identifiable, Codable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let emoji: String
}
