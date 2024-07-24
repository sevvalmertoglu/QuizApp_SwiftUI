//
//  ProfileView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 23.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var appState: AppState
    @State private var navigateToSplashView = false

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()

            Button(action: {
                viewModel.logOut()
                navigateToSplashView = true
            }) {
                Text("Log Out")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .background(
                NavigationLink(destination: SplashView(), isActive: $navigateToSplashView) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel(appState: AppState()))
            .environmentObject(AppState())
    }
}
