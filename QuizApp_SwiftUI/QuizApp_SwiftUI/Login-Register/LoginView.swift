//
//  LoginView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var navigateToNumberOfQuestions = false
    
    var body: some View {
                VStack {
                    NavigationLink(
                        destination: NumberOfQuestionsView()
                            .navigationBarBackButtonHidden(true),
                        isActive: $navigateToNumberOfQuestions,
                        label: {
                            EmptyView()
                        })
                    .hidden()
                    AuthHeaderView(title1: "Hello,", title2: "Welcome back")
                    VStack(spacing: 40) {
                        CustomInputField(imageName: "envelope",
                                         placeholderText: "Email",
                                         textCase: .lowercase,
                                         keyboardType: .emailAddress,
                                         textContentType: .emailAddress,
                                         text: $viewModel.email)
                        
                        
                        CustomInputField(imageName: "lock",
                                         placeholderText: "Password",
                                         textCase: .lowercase,
                                         keyboardType: .default,
                                         textContentType: .password,
                                         isSecureField: true,
                                         text:  $viewModel.password)
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 44)
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            Text("Reset View")
                        } label: {
                            Text("Forgot Password?")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.indigo)
                                .padding(.top)
                                .padding(.trailing, 24)
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button {
                            viewModel.signIn()
                        } label: {
                            Text("Sign In")
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
                    
                    NavigationLink  {
                        RegisterView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.footnote)
                            
                            Text("Sign Up")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.bottom, 32)
                    .foregroundColor(Color.indigo)
                }
                .ignoresSafeArea()
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }.onChange(of: viewModel.isSignedIn) { isSignedIn in
                    if isSignedIn {
                        navigateToNumberOfQuestions = true
                    }
                }
              
            }
        }
#Preview {
    LoginView()
}



