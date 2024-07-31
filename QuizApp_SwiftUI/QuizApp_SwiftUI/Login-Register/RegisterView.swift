//
//  RegisterView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AuthViewModel(appState: AppState())
    @State private var navigateToMainView = false

    var body: some View {
        VStack {
            AuthHeaderView(title1: "Get started,", title2: "Create your account")
            VStack(spacing: 40) {
                CustomInputField(
                    imageName: "envelope",
                    placeholderText: "Email",
                    textCase: .lowercase,
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    text: self.$viewModel.email
                )

                CustomInputField(
                    imageName: "person",
                    placeholderText: "Username",
                    textCase: .lowercase,
                    keyboardType: .default,
                    textContentType: .username,
                    text: self.$viewModel.nickname
                )

                CustomInputField(
                    imageName: "person",
                    placeholderText: "Full name",
                    textContentType: .name,
                    textInputAutoCapital: .words,
                    text: self.$viewModel.name
                )

                CustomInputField(
                    imageName: "lock",
                    placeholderText: "Password",
                    textContentType: .newPassword,
                    isSecureField: true,
                    text: self.$viewModel.password
                )
            }
            .padding(32)

            if self.viewModel.isLoading {
                ProgressView()
            } else {
                Button {
                    self.viewModel.register()
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.indigo)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }

            Spacer()

            NavigationLink {
                LoginView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)

                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color.indigo)
        }
        .ignoresSafeArea()
        .alert(isPresented: self.$viewModel.showAlert) {
            Alert(title: Text("Warning"), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }.onChange(of: self.viewModel.isSignedIn) { _, isSignedIn in
            if isSignedIn {
                self.navigateToMainView = true
            }
        }
        .background(NavigationLink(
            destination: MainView()
                .navigationBarBackButtonHidden(true),
            isActive: self.$navigateToMainView,
            label: {
                EmptyView()
            }
        )
        .hidden()
        )
    }
}

#Preview {
    RegisterView()
}
