//
//  ProfileView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 23.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    @EnvironmentObject var appState: AppState
    @State private var navigateToSplashView = false

    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(appState: appState))
    }

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()

            if self.viewModel.isLoading {
                ProgressView()
            } else {
                Text("Name: \(self.viewModel.name)")
                    .font(.headline)
                    .padding(.top, 20)
                Text("Nickname: \(self.viewModel.nickname)")
                    .font(.headline)
                    .padding(.top, 5)
                Text("Email: \(self.viewModel.email)")
                    .font(.headline)
                    .padding(.top, 5)

                Spacer()

                Button(action: {
                    self.viewModel.logOut()
                    self.navigateToSplashView = true
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.top, 20)

                Button(action: {
                    self.viewModel.showConfirmationDialog = true
                }) {
                    Text("Delete Account")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .alert(isPresented: self.$viewModel.showConfirmationDialog) {
                    Alert(
                        title: Text("Confirm Delete"),
                        message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                        primaryButton: .destructive(Text("Yes")) {
                            self.navigateToSplashView = true
                            self.viewModel.deleteUserAccount()
                        },
                        secondaryButton: .cancel()
                    )
                }

                Button(action: {
                    self.viewModel.resetPassword()
                }) {
                    Text("Reset Password")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
            }

            Spacer()

            if self.viewModel.showAlert {
                Text(self.viewModel.alertMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            NavigationLink(
                destination: SplashView()
                    .navigationBarBackButtonHidden(true),
                isActive: self.$navigateToSplashView
            ) {
                EmptyView()
            }
            .hidden()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(appState: AppState())
            .environmentObject(AppState())
    }
}
