//
//  LeaderBoardView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 9.08.2024.
//

import SwiftUI

struct LeaderBoardView: View {
    @State private var showCategorySelector: Bool = true

    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    self.showCategorySelector.toggle()
                }) {
                    Image(systemName: "list.star")
                        .foregroundColor(self.showCategorySelector ? .green : .gray)
                }
            }.offset(x: 150, y: -100)

            HStack(spacing: 0) {
                // Left Stack (Rank 2)
                LeaderBoardStack(rankImage: QuizAppImages.instance.Rank2.asImage, medalImage: "Medal2", userImage: "user", username: "Ayşe Can", score: "1500 puan", width: 90, height: 240, rankOffset: 30)

                // Center Stack (Rank 1)
                LeaderBoardStack(rankImage: QuizAppImages.instance.Rank1.asImage, medalImage: "Medal1", userImage: "user", username: "Ayşe Can", score: "1500 puan", width: 100, height: 280, rankOffset: 0)

                // Right Stack (Rank 3)
                LeaderBoardStack(rankImage: QuizAppImages.instance.Rank3.asImage, medalImage: "Medal3", userImage: "user", username: "Ayşe Can", score: "1500 puan", width: 90, height: 240, rankOffset: 40)
            }
            .padding(.horizontal, 20)
            .offset(y: -80)
        }
        .sheet(isPresented: self.$showCategorySelector, onDismiss: {}) {
            // Sheet içinde gösterilecek view
            LeaderRankingView()
                .presentationDetents([.medium, .fraction(0.8), .height(300)])
                .presentationBackground(.thinMaterial)
                .presentationCornerRadius(50)
        }
    }
}

#Preview {
    LeaderBoardView()
}
