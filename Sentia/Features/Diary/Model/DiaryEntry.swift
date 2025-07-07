//
//  DiaryEntry.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import Foundation

/// Model representing a single diary entry with emotional metadata and response message.
struct DiaryEntry: Codable, Identifiable, Equatable {
    var id = UUID()
    let emotionGroupID: UUID
    let feelingID: UUID
    let emotionGroup: String
    let feeling: String
    let emojiGroup: String
    let emojiFeeling: String
    let message: String
    let date: Date
    
    init(
        emotionGroupID: UUID,
        feelingID: UUID,
        emotionGroup: String,
        feeling: String,
        emojiGroup: String,
        emojiFeeling: String,
        message: String,
        date: Date
    ) {
        self.id = UUID()
        self.emotionGroupID = emotionGroupID
        self.feelingID = feelingID
        self.emotionGroup = emotionGroup
        self.feeling = feeling
        self.emojiGroup = emojiGroup
        self.emojiFeeling = emojiFeeling
        self.message = message
        self.date = date
    }
}
