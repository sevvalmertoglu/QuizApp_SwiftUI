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

    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }

    var body: some View {
        TabView {
            CategoryView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }

            LeaderBoardView()
                .tabItem {
                    Label("Leader Board", systemImage: "medal.star.fill")
                }

            ProfileView(appState: self.appState)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        .accentColor(.indigo)
    }
}

#Preview {
    MainView()
}
