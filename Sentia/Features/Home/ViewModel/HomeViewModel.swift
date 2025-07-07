//
//  HomeViewModel.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

//
//  HomeViewModel.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import Foundation

/// ViewModel responsible for managing the home screen state, emotion group selection, and navigation logic.
final class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// List of loaded emotion groups from the feelings service.
    @Published private(set) var emotionGroups: [EmotionGroup] = []
    
    /// Currently selected emotion group.
    @Published var selectedGroup: EmotionGroup? = nil
    
    /// Currently selected feeling.
    @Published var selectedFeeling: Feeling? = nil
    
    /// Controls whether the feelings view should be shown.
    @Published var isShowingFeelings = false
    
    /// Triggers navigation to the conversation screen.
    @Published var shouldNavigateToConversation = false
    
    /// Route used for programmatic navigation.
    @Published var route: Route? = nil

    // MARK: - Dependencies
    
    private let feelingService: FeelingServiceProtocol

    // MARK: - Computed
    
    /// Feelings associated with the selected emotion group.
    var selectedGroupFeelings: [Feeling] {
        selectedGroup?.feelings ?? []
    }

    // MARK: - Init
    
    init(feelingService: FeelingServiceProtocol = FeelingService()) {
        self.feelingService = feelingService
        loadFeelings()
    }

    // MARK: - Methods
    
    /// Loads emotion groups from the service.
    func loadFeelings() {
        do {
            emotionGroups = try feelingService.loadEmotionGroups()
            selectedGroup = nil
            isShowingFeelings = false
        } catch {
            print(Constants.Home.errorLoadFeeling + "\(error)")
            emotionGroups = []
            selectedGroup = nil
            isShowingFeelings = false
        }
    }

    /// Handles selection and toggle behavior of an emotion group.
    func selectGroup(_ group: EmotionGroup) {
        if selectedGroup?.id == group.id {
            isShowingFeelings.toggle()
        } else {
            selectedGroup = group
            selectedFeeling = nil
            isShowingFeelings = true
        }
    }

    /// Updates the selected feeling.
    func selectFeeling(_ feeling: Feeling?) {
        selectedFeeling = feeling
    }

    /// Resets the navigation flag after navigation completes.
    func resetNavigationFlag() {
        shouldNavigateToConversation = false
    }

    /// Prepares the route to navigate to the conversation view.
    func goToConversation() {
        guard let group = selectedGroup, let feeling = selectedFeeling else { return }
        route = .conversation(group: group, feeling: feeling)
    }

    /// Resets all selected states.
    func resetSelection() {
        selectedFeeling = nil
        selectedGroup = nil
        isShowingFeelings = false
    }
}
