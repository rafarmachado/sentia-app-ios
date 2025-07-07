//
//  Route.swift.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import Foundation

enum Route: Hashable {
    case conversation(group: EmotionGroup, feeling: Feeling)
    case diary
}
