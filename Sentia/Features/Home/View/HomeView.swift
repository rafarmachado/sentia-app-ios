//
//  HomeView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import SwiftUI

/// The HomeView is the entry screen where the user selects an emotion group
/// and a corresponding feeling to begin a guided conversation with the app.
/// It also allows access to the user's emotion diary.
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var diaryViewModel: DiaryViewModel
    @Binding var path: [Route] 

    var body: some View {
        VStack(alignment: .leading) {
            titleSection
            emotionGroupCarousel
            feelingsGrid
            confirmationTextSection
            Spacer()
            buttonsSection
        }
        .navigationTitle(Constants.Home.navigationTitle)
        .onAppear {
            viewModel.resetSelection()
        }
    }

    private var titleSection: some View {
        Text(Constants.Home.title)
            .font(AppFonts.title)
            .bold()
            .padding(.horizontal, Spacing.defaultPadding)
    }

    private var emotionGroupCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.medium) {
                ForEach(viewModel.emotionGroups) { group in
                    EmotionGroupView(
                        group: group,
                        isSelected: viewModel.selectedGroup?.id == group.id
                    )
                    .onTapGesture {
                        viewModel.selectGroup(group)
                    }
                }
            }
            .padding(.horizontal, Spacing.defaultPadding)
        }
    }

    private var feelingsGrid: some View {
        Group {
            if viewModel.isShowingFeelings && !viewModel.selectedGroupFeelings.isEmpty {
                VStack(alignment: .leading, spacing: Spacing.small) {
                    HStack {
                        Text("\(Constants.Home.groupFeelingsTitle) \(viewModel.selectedGroup?.name ?? "")")
                            .font(AppFonts.headline)

                        Image(systemName: Constants.Home.arrowImage)
                            .foregroundColor(AppColors.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, Spacing.defaultPadding)

                    Divider()
                        .padding(.horizontal, Spacing.defaultPadding)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: Spacing.homeGridItem))],
                              spacing: Spacing.large) {
                        ForEach(viewModel.selectedGroupFeelings) { feeling in
                            FeelingView(
                                feeling: feeling,
                                isSelected: viewModel.selectedFeeling == feeling
                            )
                            .onTapGesture {
                                if viewModel.selectedFeeling == feeling {
                                    viewModel.selectFeeling(nil)
                                    viewModel.isShowingFeelings = false
                                } else {
                                    viewModel.selectFeeling(feeling)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppCornerRadius.medium)
                    .padding(.horizontal, Spacing.defaultPadding)
                }
            }
        }
    }

    private var confirmationTextSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xSmall) {
            if let group = viewModel.selectedGroup?.name,
               let feeling = viewModel.selectedFeeling?.name {

                Text("\(Constants.Home.understoodFeeling) \(feeling.lowercased()) \(Constants.Home.because) \(group.lowercased()).")
                    .font(AppFonts.title3)
                    .fontWeight(.semibold)

                Text(Constants.Home.letsListen)
                    .font(AppFonts.subheadline)
                    .foregroundColor(AppColors.secondary)
            }
        }
        .padding(.horizontal, Spacing.defaultPadding)
        .padding(.top, Spacing.large)
        .transition(.opacity)
    }

    private var buttonsSection: some View {
        VStack(spacing: Spacing.medium) {
            Button(action: {
                viewModel.goToConversation()
                if let route = viewModel.route {
                    path.append(route)
                }
            }) {
                Text(Constants.Home.listenAboutIt)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.selectedFeeling == nil ? AppColors.buttonDisabled : AppColors.primary)
                    .foregroundColor(.white)
                    .cornerRadius(AppCornerRadius.defaultRadius)
            }
            .disabled(viewModel.selectedFeeling == nil)

            Button(action: {
                path.append(.diary)
            }) {
                Text(Constants.Home.seeMyDiary)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.secondary.opacity(0.1))
                    .cornerRadius(AppCornerRadius.defaultRadius)
            }
        }
        .padding()
    }
}
