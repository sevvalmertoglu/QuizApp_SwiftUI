//
//  PreviousScoresView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 1.08.2024.
//

import SwiftUI

struct PreviousScoresView: View {
    @StateObject private var viewModel = PreviousScoresViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            QuizAppImages.instance.backgroundPreviousScores.asImage
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView {
                VStack {
                    if self.viewModel.isLoading {
                        ProgressView("Loading Scores...").foregroundColor(.black)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        ForEach(self.viewModel.scores) { score in
                            HStack {
                                Image(systemName: "arrowshape.right.fill")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 8)

                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text("Score: \(score.score)")
                                            .font(.headline)
                                            .foregroundColor(.indigo)
                                    }

                                    Spacer()

                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.indigo)
                                        Text("Date: \(score.date)")
                                            .font(.subheadline)
                                            .foregroundColor(.indigo)
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
                .padding(.top, 80)
                .padding()
            }
        }
        .onAppear {
            self.viewModel.fetchScores()
        }
        .navigationTitle("Previous Scores")
        .toolbar {
            // Toolbar customizations
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward.circle.fill")
                        .foregroundColor(.white)
                }
            }
        }
    }
}
