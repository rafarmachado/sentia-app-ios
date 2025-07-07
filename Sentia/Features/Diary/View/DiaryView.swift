//
//  DiaryView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import SwiftUI

/// A view displaying a list of diary entries.
/// If there are no entries, a placeholder message is shown.
/// Entries can be deleted via swipe-to-delete.
struct DiaryView: View {
    @EnvironmentObject var viewModel: DiaryViewModel

    var body: some View {
        List {
            if viewModel.entries.isEmpty {
                Text(Constants.Diary.emptyStateMessage)
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.grayText)
                    .padding(Spacing.medium)
            } else {
                ForEach(viewModel.entries) { entry in
                    VStack(alignment: .leading, spacing: Spacing.small) {
                        // Emotion Group and Feeling line
                        HStack(spacing: Spacing.xSmall) {
                            Text(entry.emojiGroup)
                            Text(entry.emotionGroup)
                                .fontWeight(.bold)
                            Text("•")
                            Text(entry.emojiFeeling)
                            Text(entry.feeling)
                                .fontWeight(.semibold)
                        }
                        .font(AppFonts.subheadline)

                        // Message
                        Text("“\(entry.message)”")
                            .font(AppFonts.body)
                            .padding(.vertical, Spacing.xSmall)

                        // Timestamp
                        Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                            .font(AppFonts.caption)
                            .foregroundColor(AppColors.grayText)
                    }
                    .padding(.vertical, Spacing.small)
                }
                .onDelete(perform: viewModel.deleteEntry)
            }
        }
        .navigationTitle(Constants.Diary.title)
        .onAppear {
            viewModel.refresh()
        }
    }
}
