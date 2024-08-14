//
//  LeaderRankingView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 12.08.2024.
//

import SwiftUI

struct LeaderRankingView: View {
    @StateObject private var viewModel = LeaderRankingViewModel()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<self.viewModel.otherUsers.count, id: \.self) { index in
                    HStack {
                        ZStack {
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                                .frame(width: 30, height: 30)

                            Text("\(index + 4)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .frame(width: 40)

                        Image(self.viewModel.otherUsers[index].userIcon) // User image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing, 10)

                        VStack(alignment: .leading) {
                            Text(self.viewModel.otherUsers[index].nickname) // User name
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)

                            Text("\(self.viewModel.otherUsers[index].totalScore) point") // User points
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 3)
                }
            }
            .padding()
        }
    }
}
