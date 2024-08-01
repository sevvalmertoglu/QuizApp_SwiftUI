//
//  PreviousScoresView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 1.08.2024.
//

import SwiftUI

struct PreviousScoresView: View {
    @StateObject private var viewModel = PreviousScoresViewModel()

    var body: some View {
        VStack {
            if self.viewModel.isLoading {
                ProgressView("Loading Scores...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(self.viewModel.scores) { score in
                    VStack(alignment: .leading) {
                        Text("Score: \(score.score)")
                            .font(.headline)
                        Text("Date: \(score.date)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.fetchScores()
        }
        .navigationTitle("Previous Scores")
    }
}

#Preview {
    PreviousScoresView()
}
