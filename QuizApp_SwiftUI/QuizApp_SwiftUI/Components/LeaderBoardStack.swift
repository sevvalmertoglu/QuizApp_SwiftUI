//
//  LeaderBoardStack.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 12.08.2024.
//

import SwiftUI

struct LeaderBoardStack: View {
    let rankImage: Image
    let medalImage: Image
    let userImage: String
    let username: String
    let score: String
    let width: CGFloat
    let height: CGFloat
    let rankOffset: CGFloat

    var body: some View {
        VStack {
            ZStack {
                Image(self.userImage)
                    .resizable()
                    .frame(width: self.width, height: self.width)
                self.medalImage
                    .resizable()
                    .frame(width: self.width * 0.5, height: self.width * 0.5)
                    .offset(y: -self.width * 0.5)
            }
            Text(self.username)
                .font(.headline)
            Text(self.score)
                .padding()
                .background(Color.indigo)
                .cornerRadius(20)
                .foregroundColor(.white)
            self.rankImage
                .resizable()
                .frame(width: self.width * 1.3, height: self.height)
        }
        .offset(y: self.rankOffset)
    }
}
