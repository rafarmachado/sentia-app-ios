//
//  Untitled.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

// MARK: - Mocks
final class MockFeelingService: FeelingServiceProtocol {
    let mockGroups: [EmotionGroup] = [
        EmotionGroup(name: "Calm", emoji: "🧘", feelings: [
            Feeling(name: "Peaceful", emoji: "🕊️")
        ]),
        EmotionGroup(name: "Happy", emoji: "😄", feelings: [
            Feeling(name: "Joyful", emoji: "😁")
        ])
    ]
    
    func loadEmotionGroups() throws -> [EmotionGroup] {
        let mockJSON = """
           [
             {
               "name": "Triste",
               "emoji": "😢",
               "feelings": [
                 { "name": "Desamparado", "emoji": "😔" },
                 { "name": "Desmotivado", "emoji": "😞" }
               ]
             },
                {
                  "name": "Ansioso",
                  "emoji": "😰",
                  "feelings": [
                    { "name": "Medo", "emoji": "😰" },
                    { "name": "Preocupado", "emoji": "😟" },
                    { "name": "Estressado", "emoji": "😤" }
                  ]
                }
           ]
           """.data(using: .utf8)!
        
        return try JSONDecoder().decode([EmotionGroup].self, from: mockJSON)
    }
}

// Mock que simula erro proposital
final class BrokenMockFeelingService: FeelingServiceProtocol {
    func loadEmotionGroups() throws -> [EmotionGroup] {
        throw NSError(domain: "TestError", code: 1, userInfo: nil)
    }
}
