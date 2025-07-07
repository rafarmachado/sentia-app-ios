//
//  SentiaApp.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import SwiftUI

/// Entry point of the Sentia app.
/// Configures the initial window and launches the RootCoordinatorView.
/// Forces the light mode as the default color scheme.
@main
struct SentiaApp: App {
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView()
                .preferredColorScheme(.light)
        }
    }
}
