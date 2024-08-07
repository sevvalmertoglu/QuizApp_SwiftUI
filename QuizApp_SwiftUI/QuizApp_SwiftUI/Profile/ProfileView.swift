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
    @State private var navigateToPreviousScoresView = false

    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(appState: appState))
    }

    let userImage = QuizAppImage(resource: .user)

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("Profile")
                            .font(.title)
                            .padding(.top, 40)

                        self.userImage.asImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150, alignment: .top)
                            .clipShape(Circle())
                            .shadow(color: .purple, radius: 5, x: 5, y: 5)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.indigo]),
                            startPoint: .leading,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(40)
                    .ignoresSafeArea(edges: .top)

                    VStack(alignment: .center, spacing: 15) {
                        if self.viewModel.isLoading {
                            ProgressView()
                        } else {
                            RoundedRectangle(cornerRadius: 120)
                                .frame(width: 350, height: 35, alignment: .center)
                                .foregroundColor(.white)
                                .shadow(color: .purple, radius: 8, y: 5)
                                .overlay(Text("Name: \(self.viewModel.name)")
                                    .foregroundColor(.indigo)
                                    .font(.system(size: 19)))

                            RoundedRectangle(cornerRadius: 120)
                                .frame(width: 350, height: 35, alignment: .center)
                                .foregroundColor(.white)
                                .shadow(color: .indigo, radius: 8, y: 5)
                                .overlay(Text("Nickname: \(self.viewModel.nickname)")
                                    .foregroundColor(.indigo)
                                    .font(.system(size: 19)))

                            RoundedRectangle(cornerRadius: 120)
                                .frame(width: 350, height: 35, alignment: .center)
                                .foregroundColor(.white)
                                .shadow(color: .pink, radius: 8, y: 5)
                                .overlay(Text("Mail: \(self.viewModel.email)")
                                    .foregroundColor(.indigo)
                                    .font(.system(size: 17)))
                        }
                    }.padding(.top, -30)

                    Spacer()

                    VStack {
                        Button(action: {
                            self.navigateToPreviousScoresView = true
                        }) {
                            Text("Previous Scores")
                                .padding()
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity)
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal, 20)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

                        Button(action: {
                            self.viewModel.logOut()
                            self.navigateToSplashView = true
                        }) {
                            Text("Log Out")
                                .padding()
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity)
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal, 20)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

                        Button(action: {
                            self.viewModel.resetPassword()
                        }) {
                            Text("Reset Password")
                                .padding()
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity)
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal, 20)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

                        Button(action: {
                            self.viewModel.showConfirmationDialog = true
                        }) {
                            Text("Delete Account")
                                .padding()
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, maxHeight: 30)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 50)
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
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
                    }.padding(.bottom, -90)

                    Spacer()

                    if self.viewModel.showAlert {
                        Text(self.viewModel.alertMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    NavigationLink(
                        destination: PreviousScoresView(),
                        isActive: self.$navigateToPreviousScoresView
                    ) {
                        EmptyView()
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
    }
}

#Preview {
    ProfileView(appState: AppState())
        .environmentObject(AppState())
}
