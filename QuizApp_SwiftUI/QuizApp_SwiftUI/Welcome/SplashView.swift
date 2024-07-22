//
//  SplashView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 22.07.2024.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .padding()
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }.navigationTitle("Welcome")
        }
    }
}

#Preview {
    SplashView()
}
