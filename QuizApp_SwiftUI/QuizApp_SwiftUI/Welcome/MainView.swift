//
//  MainView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 23.07.2024.
//

import CoreAPI
import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            CategoryView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }

            ProfileView(appState: self.appState)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
