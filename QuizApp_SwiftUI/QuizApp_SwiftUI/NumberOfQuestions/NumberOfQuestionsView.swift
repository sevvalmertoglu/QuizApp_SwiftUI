//
//  NumberOfQuestionsView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct NumberOfQuestionsView: View {
    @State var number = 10
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                AuthHeaderView(title1: "Please", title2: "select number of questions")
                    .position(CGPoint(x: 196.0, y: 70.0))
                
                Text("Number of Questions: \(number)")
                    .padding()
                
                Stepper(value: $number, in: 1...25) {
                    Text("Number Of Questions:").padding()
                }.padding()
                
                Spacer()
                
                NavigationLink(destination: CategoryView()) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 140, height: 50)
                        .background(Color.indigo)
                        .clipShape(Capsule())
                        .padding()
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                }
                .buttonStyle(PlainButtonStyle())
                .position(x: 200, y: 250)
            }
        }
    }
}


#Preview {
    NumberOfQuestionsView()
}
