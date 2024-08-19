//
//  ProfileSettingsView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 16.08.2024.
//

import FirebaseAuth
import SwiftUI

struct ProfileSettingsView: View {
    @StateObject private var viewModel = ProfileSettingsViewModel()
    @State private var navigateToUserIconView = false
    @State private var userId: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 30) {
            ZStack(alignment: .bottomTrailing) {
                if let userIcon = viewModel.userIcon {
                    Image(uiImage: userIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                        .shadow(color: .purple, radius: 5, x: 5, y: 5)
                } else {
                    QuizAppImages.instance.user.asImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                        .shadow(color: .purple, radius: 5, x: 5, y: 5)
                }

                Button(action: {
                    self.navigateToUserIconView = true
                }) {
                    Image(systemName: "photo.badge.plus")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.pink)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .offset(x: 0, y: 0)
            }

            VStack(spacing: 30) {
                ProfileSettingsTextField(icon: "pencil.circle", placeHolder: "Name Surname", text: self.$viewModel.name)

                ProfileSettingsTextField(icon: "pencil.circle", placeHolder: "Nickname", text: self.$viewModel.nickname)
            }
            .padding()

            Button(action: {
                self.viewModel.saveProfileChanges(userId: self.userId)
            }) {
                Text("Save Changes")
            }
            .buttonStyle()
            .padding()

            Spacer()

            NavigationLink(
                destination: UserIconView(),
                isActive: self.$navigateToUserIconView
            ) {
                EmptyView()
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.indigo]), startPoint: .topTrailing, endPoint: .bottomLeading)
        )
        .navigationTitle("Profile Settings")
        .onAppear {
            if let currentUser = Auth.auth().currentUser {
                self.userId = currentUser.uid
                self.viewModel.fetchUserProfile(userId: self.userId)
            } else {
                self.viewModel.alertMessage = "No user is currently logged in."
                self.viewModel.showAlert = true
            }
        }
        .alert(isPresented: self.$viewModel.showAlert) {
            Alert(
                title: Text("Information"),
                message: Text(self.viewModel.alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    if self.viewModel.alertMessage == NSLocalizedString("Profile information saved successfully!", comment: "") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                })
            )
        }
    }
}

#Preview {
    NavigationView {
        ProfileSettingsView()
    }
}
