//
//  LeaderBoardView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 9.08.2024.
//

import SwiftUI

struct LeaderBoardView: View {
    @StateObject private var viewModel = LeaderBoardViewModel()
    @State private var showCategorySelector: Bool = true
    @State private var isAnimating: Bool = false
    @Namespace private var namespace
    @State var isClicked: Bool = false

    var body: some View {
        VStack {
            if self.viewModel.isLoading {
                ProgressView("Loading Leaderboard...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding(.top, 50)
            } else {
                ZStack(alignment: .topTrailing) {
                    if !self.isClicked {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.showCategorySelector = true
                                }
                                self.isClicked.toggle()
                            }
                        }) {
                            Text("Other Scores")
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.green)
                                .cornerRadius(15)
                                .matchedGeometryEffect(id: "heroButton", in: self.namespace)
                        }
                        .offset(y: self.isClicked ? UIScreen.main.bounds.height : 0)
                        .padding()
                    }

                    Spacer()

                    HStack(spacing: 0) {
                        // Left Stack (Rank 2)
                        if self.viewModel.topThreeUsers.count > 1 {
                            LeaderBoardStack(
                                rankImage: QuizAppImages.instance.Rank2.asImage,
                                medalImage: QuizAppImages.instance.Medal2.asImage,
                                userImage: self.viewModel.topThreeUsers[1].userIcon,
                                username: self.viewModel.topThreeUsers[1].nickname,
                                score: "\(self.viewModel.topThreeUsers[1].totalScore) point",
                                width: 90,
                                height: 240,
                                rankOffset: 30
                            )
                        }

                        // Center Stack (Rank 1)
                        if !self.viewModel.topThreeUsers.isEmpty {
                            LeaderBoardStack(
                                rankImage: QuizAppImages.instance.Rank1.asImage,
                                medalImage: QuizAppImages.instance.Medal1.asImage,
                                userImage: self.viewModel.topThreeUsers[0].userIcon,
                                username: self.viewModel.topThreeUsers[0].nickname,
                                score: "\(self.viewModel.topThreeUsers[0].totalScore) point",
                                width: 100,
                                height: 280,
                                rankOffset: 0
                            )
                        }

                        // Right Stack (Rank 3)
                        if self.viewModel.topThreeUsers.count > 2 {
                            LeaderBoardStack(
                                rankImage: QuizAppImages.instance.Rank3.asImage,
                                medalImage: QuizAppImages.instance.Medal3.asImage,
                                userImage: self.viewModel.topThreeUsers[2].userIcon,
                                username: self.viewModel.topThreeUsers[2].nickname,
                                score: "\(self.viewModel.topThreeUsers[2].totalScore) point",
                                width: 90,
                                height: 240,
                                rankOffset: 40
                            )
                        }
                    }
                    .padding([.horizontal, .top], 20)
                    .padding(.bottom, 120)
                    .frame(maxHeight: .infinity)
                }
                .background(
                    QuizAppImages.instance.backgroundLeaderBoard.asImage
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                )
                .sheet(isPresented: self.$showCategorySelector, onDismiss: {}) {
                    LeaderRankingView(namespace: self.namespace, isClicked: self.$isClicked)
                        .presentationDetents([.medium, .fraction(0.8), .height(300)])
                        .presentationBackground(.thinMaterial)
                        .presentationCornerRadius(50)
                        .presentationDragIndicator(.hidden)
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                self.isClicked.toggle()
            }
        }
        .onAppear {
            self.showCategorySelector = true
        }
    }
}
