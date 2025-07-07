//
//  SplashView.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Image(Constants.Splash.splash_image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .transition(.opacity)
        }
    }
}
