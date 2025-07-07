//
//  MainFlowFactory.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import Foundation
import SwiftUICore

final class MainFlowFactory {
    static func makeConversationView(group: EmotionGroup, feeling: Feeling, diaryManager: DiaryManagerProtocol) -> some View {
        let useCase = DefaultConversationUseCase(
            service: ConversationService(apiKey: LoadAPIKey().loadAPIKey())
        )
        let viewModel = ConversationViewModel(
            emotionalGroup: group,
            feeling: feeling,
            useCase: useCase,
            diaryManager: diaryManager
        )
        return ConversationView(viewModel: viewModel)
    }
}
