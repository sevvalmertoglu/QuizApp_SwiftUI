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
        ScrollView {
            VStack {
                if self.viewModel.isLoading {
                    ProgressView("Loading Scores...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ForEach(self.viewModel.scores) { score in
                        HStack {
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundColor(.indigo)
                                .padding(.trailing, 8)

                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text("Score: \(score.score)")
                                        .font(.headline)
                                }

                                Spacer()

                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.indigo)
                                    Text("Date: \(score.date)")
                                        .font(.subheadline)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 3)

                            Spacer()
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            self.viewModel.fetchScores()
        }
        .navigationTitle("Previous Scores")
    }
}
