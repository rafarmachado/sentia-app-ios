//
//  ConversationView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import SwiftUI

/// A SwiftUI view that displays a generated emotional response based on the user's selected emotion group and feeling.
///
/// The view fetches a short supportive message from the `ConversationViewModelProtocol`, and allows the user to save it to their diary.
/// It presents:
/// - A header showing the selected emotion group and feeling
/// - A contextual empathy message
/// - A generated response (or loading/error state)
/// - Action buttons to regenerate or save the response
///
/// Visual feedback such as a confirmation label is shown when saved successfully.
struct ConversationView<ViewModel: ConversationViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var showResponse = false
    @State private var showSavedMessage: Bool = false

    var body: some View {
        mainContent
    }

    private var mainContent: some View {
        VStack(spacing: Spacing.large) {
            headerSection
            Divider()
            empathySection
            responseSection

            if let date = viewModel.date {
                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.grayText)
            }

            Spacer()

            if showSavedMessage {
                Text(Constants.Conversation.savedMessageSuccess)
                    .font(.footnote)
                    .foregroundColor(AppColors.primary)
                    .padding(.bottom, 4)
                    .transition(.opacity)
            }

            buttonsSection
        }
        .padding(Spacing.defaultPadding)
        .navigationTitle(Constants.Conversation.title)
        .background(colorScheme == .dark ? AppColors.backgroundDark : AppColors.backgroundLight)
        .animation(.easeInOut, value: viewModel.showSavedLabel)
    }

    private var headerSection: some View {
        HStack {
            Spacer()
            VStack(spacing: Spacing.small) {
                ZStack {
                    Circle()
                        .fill(AppColors.primary.opacity(0.2))
                        .frame(width: 72, height: 72)
                    Text(viewModel.emotionGroupEmoji)
                        .font(AppFonts.emoji)
                }
                Text(viewModel.emotionGroupName)
                    .font(AppFonts.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()
            VStack(spacing: Spacing.small) {
                ZStack {
                    Circle()
                        .fill(AppColors.secondary.opacity(0.2))
                        .frame(width: 72, height: 72)
                    Text(viewModel.feelingEmoji)
                        .font(AppFonts.emoji)
                }
                Text(viewModel.feelingName)
                    .font(AppFonts.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
    }

    private var empathySection: some View {
        VStack(spacing: Spacing.xSmall) {
            Text(Constants.Conversation.understood)
                .font(AppFonts.headline)
                .foregroundColor(AppColors.grayText)
                .bold()

            Text("\(viewModel.feelingName.lowercased()) \(Constants.Conversation.because) \(viewModel.emotionGroupName.lowercased()).")
                .font(AppFonts.headline)
                .bold()
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, Spacing.defaultPadding)
    }

    private var responseSection: some View {
        Group {
            if viewModel.isLoading {
                ProgressView(Constants.Conversation.loadingResponse)
                    .padding(.top)
            } else if let error = viewModel.error {
                Text("\(Constants.Conversation.errorPrefix) \(error)")
                    .foregroundColor(AppColors.error)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let response = viewModel.response {
                Text("\"\(response)\"")
                    .font(AppFonts.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.defaultPadding)
                    .transition(.opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.4)) {
                            showResponse = true
                        }
                    }
            }
        }
    }

    private var buttonsSection: some View {
        VStack(spacing: Spacing.medium) {
            Button {
                showResponse = false
                viewModel.fetchResponse()
            } label: {
                Label(Constants.Conversation.listenButton,
                      systemImage: Constants.Conversation.buttonIcon)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)

            Button {
                viewModel.saveToDiary()
                withAnimation {
                    showSavedMessage = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        showSavedMessage = false
                    }
                }
            } label: {
                if viewModel.isSaving {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Label(Constants.Conversation.saveButton,
                          systemImage: Constants.Conversation.saveImage)
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.bordered)
            .tint(AppColors.primary)
            .disabled(viewModel.response == nil)
        }
        .padding(.horizontal, Spacing.defaultPadding)
    }
}
