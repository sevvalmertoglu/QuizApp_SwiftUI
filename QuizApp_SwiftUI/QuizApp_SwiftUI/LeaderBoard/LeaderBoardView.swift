//
//  LeaderBoardView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 9.08.2024.
//

import SwiftUI

struct LeaderBoardView: View {
    @StateObject private var viewModel = LeaderBoardViewModel()
    @State private var shouldShownSheet: Bool = true
    @State private var isAnimating: Bool = false
    @Namespace private var namespace

    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.55
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0

    var body: some View {
        ZStack {
            VStack {
                if self.viewModel.isLoading {
                    ProgressView("Loading Leaderboard...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding(.top, 50)
                } else {
                    ZStack(alignment: .topTrailing) {
                        if !self.shouldShownSheet {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.shouldShownSheet.toggle()
                                }
                            }) {
                                Text("Other Scores")
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color.green)
                                    .cornerRadius(15)
                                    .matchedGeometryEffect(id: "heroButton", in: self.namespace)
                            }
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
                }
            }

            // Custom Sheet
            LeaderRankingView(namespace: self.namespace, shouldShownSheet: self.$shouldShownSheet)
                .offset(y: self.startingOffsetY)
                .offset(y: self.currentDragOffsetY)
                .offset(y: self.endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                self.currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                if self.currentDragOffsetY < -150 {
                                    self.endingOffsetY = -self.startingOffsetY
                                } else if self.endingOffsetY != 0, self.currentDragOffsetY > 150 {
                                    self.endingOffsetY = 0
                                }
                                self.currentDragOffsetY = 0
                            }
                        }
                )
                .opacity(self.shouldShownSheet ? 1 : 0)
        }
        .onAppear {
            self.shouldShownSheet = true
        }
    }
}
