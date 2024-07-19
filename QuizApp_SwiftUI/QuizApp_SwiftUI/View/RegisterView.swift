//
//  RegisterView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Get started,", title2: "Create your account")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 textCase: .lowercase,
                                 keyboardType: .emailAddress,
                                 textContentType: .emailAddress,
                                 text:  $viewModel.email)
                
                CustomInputField(imageName: "person",
                                 placeholderText: "Username",
                                 textCase: .lowercase,
                                 keyboardType: .default,
                                 textContentType: .username,
                                 text:$viewModel.nickname)
                
                CustomInputField(imageName: "person",
                                 placeholderText: "Full name",
                                 textContentType: .name,
                                 textInputAutoCapital: .words,
                                 text: $viewModel.name)
                
                CustomInputField(imageName: "lock",
                                 placeholderText: "Password",
                                 textContentType: .newPassword,
                                 isSecureField: true,
                                 text: $viewModel.password)
            }
            .padding(32)
            
            Button {
                print("Sign Up")
                viewModel.register()
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
            
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
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

        }
        .ignoresSafeArea()
    }
}
#Preview {
    RegisterView()
}
