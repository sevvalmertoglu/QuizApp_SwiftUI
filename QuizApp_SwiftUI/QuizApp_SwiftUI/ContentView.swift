//
//  ContentView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 16.07.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if self.appState.isUserLoggedIn {
                MainView()
            } else {
                SplashView()
            }
        }
    }
}
