//
//  EmotionGroupView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 04/07/25.
//

import SwiftUI

/// A view representing an `EmotionGroup` with its emoji and name.
/// The emoji is highlighted if the group is selected.
/// - Parameters:
///   - group: The emotion group to display.
///   - isSelected: A boolean indicating if the group is selected.
///
struct EmotionGroupView: View {
    let group: EmotionGroup
    let isSelected: Bool

    private enum UIConstants {
        static let unselectedBackground = Color.gray.opacity(0.1)
        static let selectedBackground = Color.blue.opacity(0.3)
    }

    var body: some View {
        VStack {
            Text(group.emoji)
                .font(.largeTitle)
                .padding()
                .background(isSelected ? UIConstants.selectedBackground : UIConstants.unselectedBackground)
                .clipShape(Circle())

            Text(group.name)
                .font(.caption)
        }
    }
}
