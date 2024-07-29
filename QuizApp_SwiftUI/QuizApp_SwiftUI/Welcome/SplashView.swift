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
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: -5, y: 14)

                Text("Welcome Quiz App!")
                    .bold()
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.bottom, 160)

                VStack {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }.padding(.horizontal, 50)

                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }.padding(.horizontal, 50)
                    Spacer().frame(height: 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 300)
            }
        }
    }
}

#Preview {
    SplashView()
}
