//
//  ConversationViewModel.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import Foundation
import SwiftUI

protocol ConversationViewModelProtocol: ObservableObject {
    var emotionGroupName: String { get }
    var emotionGroupEmoji: String { get }
    var feelingName: String { get }
    var feelingEmoji: String { get }

    var isSaving: Bool { get }
    var showSavedLabel: Bool { get set }

    var isLoading: Bool { get }
    var response: String? { get }
    var error: String? { get }
    var date: Date? { get }

    func fetchResponse()
    func saveToDiary()
}

/// ViewModel responsible for handling the logic of emotional conversation flow.
///
/// It interacts with the `ConversationUseCase` to generate empathetic responses and
/// with `DiaryManager` to persist the conversation.
final class ConversationViewModel: ConversationViewModelProtocol {
    // MARK: - Published Properties
    /// Indicates if a response is being fetched.
    @Published private(set) var isLoading = false
    
    /// The response from the GPT API.
    @Published var response: String?
    
    /// Any error that occurred during the fetch.
    @Published var error: String?
    
    /// Timestamp of the response.
    @Published var date: Date?
    
    /// Whether the diary is being saved.
    @Published var isSaving: Bool = false
    
    /// Controls the display of the saved label.
    @Published var showSavedLabel: Bool = false

    // MARK: - Emotion Metadata
    let emotionGroupName: String
    let emotionGroupEmoji: String
    let feelingName: String
    let feelingEmoji: String

    private let emotionGroupID: UUID
    private let feelingID: UUID

    // MARK: - Dependencies
    private let useCase: ConversationUseCase
    private let diaryManager: DiaryManagerProtocol

    // MARK: - Init
    init(emotionalGroup: EmotionGroup,
         feeling: Feeling,
         useCase: ConversationUseCase,
         diaryManager: DiaryManagerProtocol) {
        self.emotionGroupName = emotionalGroup.name
        self.emotionGroupEmoji = emotionalGroup.emoji
        self.feelingName = feeling.name
        self.feelingEmoji = feeling.emoji
        self.emotionGroupID = emotionalGroup.id
        self.feelingID = feeling.id
        self.useCase = useCase
        self.diaryManager = diaryManager
    }

    // MARK: - Methods

    func fetchResponse() {
        guard !isLoading else { return }

        isLoading = true
        response = nil
        error = nil
        date = nil

        let prompt = "\(Constants.Conversation.prompt) \(feelingName.lowercased())."
        let context = emotionGroupName

        Task {
            do {
                let reply = try await useCase.getReply(prompt: prompt, context: context)
                await MainActor.run {
                    self.response = String(reply.prefix(150))
                    self.date = Date()
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }

    func saveToDiary() {
        guard let response, let date else { return }
        isSaving = true
        
        let entry = DiaryEntry(
            emotionGroupID: emotionGroupID,
            feelingID: feelingID,
            emotionGroup: emotionGroupName,
            feeling: feelingName,
            emojiGroup: emotionGroupEmoji,
            emojiFeeling: feelingEmoji,
            message: response,
            date: date
        )
        
        diaryManager.save(entry: entry)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isSaving = false
            withAnimation {
                self.showSavedLabel = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.showSavedLabel = false
                }
            }
        }
    }
}
