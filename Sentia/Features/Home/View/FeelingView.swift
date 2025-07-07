//
//  FeelingView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 04/07/25.
//

import SwiftUI

/// A view representing a single emotional `Feeling` with its emoji and name.
/// Highlights the emoji when selected by changing the background.
/// - Parameters:
///   - feeling: The `Feeling` model containing emoji and name.
///   - isSelected: Indicates whether this feeling is currently selected.
///   
struct FeelingView: View {
    let feeling: Feeling
    let isSelected: Bool

    var body: some View {
        VStack {
            Text(feeling.emoji)
                .font(.title)
                .padding()
                .background(isSelected ? Color.green.opacity(0.3) : Color.white.opacity(0.2))
                .clipShape(Circle())
            Text(feeling.name)
                .font(.caption)
        }
    }
}
