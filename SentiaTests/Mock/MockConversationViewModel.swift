//
//  MockViewModel.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

// MARK: - Mock ViewModel
    final class MockConversationViewModel: ConversationViewModelProtocol {
        var emotionGroupName = "Triste"
        var emotionGroupEmoji = "😢"
        var feelingName = "Desamparado"
        var feelingEmoji = "😔"
        
        var isSaving = false
        var showSavedLabel = false
        var isLoading = false
        var response: String? = nil
        var error: String? = nil
        var date: Date? = nil
        
        private(set) var didCallFetch = false
        private(set) var didCallSave = false
        
        func fetchResponse() {
            didCallFetch = true
        }
        
        func saveToDiary() {
            didCallSave = true
        }
    }
    
