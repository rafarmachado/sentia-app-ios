//
//  MainFlowView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import SwiftUI

struct MainFlowView: View {
    @StateObject private var diaryManager = DiaryManager()
    @StateObject private var diaryViewModel: DiaryViewModel
    @State private var path: [Route] = []
    
    init() {
        let manager = DiaryManager()
        _diaryManager = StateObject(wrappedValue: manager)
        _diaryViewModel = StateObject(wrappedValue: DiaryViewModel(diaryManager: manager))
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .environmentObject(diaryViewModel)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case let .conversation(group, feeling):
                        MainFlowFactory.makeConversationView(group: group, feeling: feeling, diaryManager: diaryManager)
                    case .diary:
                        DiaryView()
                            .environmentObject(diaryViewModel)
                    }
                }
        }
    }
}
