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
                    .position(x:200, y:345)
                
               
                VStack {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            
                    }
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .padding()
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }.position(x:200,y:600)
            }
        }
    }
}

#Preview {
    SplashView()
}
