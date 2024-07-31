//
//  MainView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 23.07.2024.
//

import CoreAPI
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CategoryView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
