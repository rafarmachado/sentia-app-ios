//
//  RootCoordinatorView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import SwiftUI

struct RootCoordinatorView: View {
    @StateObject private var viewModel = RootCoordinatorViewModel()

    var body: some View {
        ZStack {
            if viewModel.showSplash {
                SplashView()
            } else {
                MainFlowView()
            }
        }
        .onAppear {
            viewModel.start()
        }
    }
}
