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
    @State private var navigateToProfileSettingsView = false

    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(appState: appState))
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("Profile")
                            .font(.title)
                            .padding(.top, 40)

                        ZStack(alignment: .bottomTrailing) {
                            if let userIcon = viewModel.userIcon {
                                Image(uiImage: userIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130, height: 130)
                                    .clipShape(Circle())
                                    .shadow(color: .purple, radius: 5, x: 5, y: 5)
                            } else {
                                // Default placeholder image if no icon is available
                                QuizAppImages.instance.user.asImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130, height: 130)
                                    .clipShape(Circle())
                                    .shadow(color: .purple, radius: 5, x: 5, y: 5)
                            }

                            Button(action: {
                                self.navigateToProfileSettingsView = true
                            }) {
                                Image(systemName: "pencil.and.scribble")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.pink)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .offset(x: 0, y: 0)
                        }
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
                                .roundedRectangleStyle(
                                    shadowColor: .purple,
                                    text: "Name: \(self.viewModel.name)",
                                    fontSize: 19
                                )

                            RoundedRectangle(cornerRadius: 120)
                                .roundedRectangleStyle(
                                    shadowColor: .indigo,
                                    text: "Nickname: \(self.viewModel.nickname)",
                                    fontSize: 19
                                )

                            RoundedRectangle(cornerRadius: 120)
                                .roundedRectangleStyle(
                                    shadowColor: .pink,
                                    text: "Mail: \(self.viewModel.email)",
                                    fontSize: 17
                                )

                            RoundedRectangle(cornerRadius: 120)
                                .roundedRectangleStyle(
                                    shadowColor: .blue,
                                    text: "Total Score: \(self.viewModel.totalScore)",
                                    fontSize: 17
                                )
                        }
                    }.padding(.top, -30)

                    Spacer()

                    VStack {
                        Button(action: {
                            self.navigateToPreviousScoresView = true
                        }) {
                            Text("Previous Scores")
                        }
                        .buttonStyle()

                        Button(action: {
                            self.viewModel.logOut()
                            self.navigateToSplashView = true
                        }) {
                            Text("Log Out")
                        }
                        .buttonStyle()

                        Button(action: {
                            self.viewModel.resetPassword()
                        }) {
                            Text("Reset Password")
                        }
                        .buttonStyle()

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

                    NavigationLink(
                        destination: ProfileSettingsView(),
                        isActive: self.$navigateToProfileSettingsView
                    ) {
                        EmptyView()
                    }

                    NavigationLink(
                        destination: PreviousScoresView()
                            .navigationBarBackButtonHidden(true),
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
