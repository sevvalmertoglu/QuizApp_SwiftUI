//
//  LeaderRankingViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 13.08.2024.
//

import Foundation

class LeaderRankingViewModel: ObservableObject {
    @Published var otherUsers: [(nickname: String, totalScore: Int, userId: String, userIcon: String)] = []

    private let firebaseManager = FirebaseManager.shared

    func fetchOtherUsers() {
        self.firebaseManager.fetchLeaderboard { result in
            switch result {
            case let .success(leaderboard):
                let sortedLeaderboard = leaderboard.sorted { $0.totalScore > $1.totalScore }
                for user in sortedLeaderboard.dropFirst(3).prefix(7) {
                    self.firebaseManager.fetchUserIcon(userId: user.userId) { iconResult in
                        switch iconResult {
                        case let .success(iconName):
                            DispatchQueue.main.async {
                                self.otherUsers.append((nickname: user.nickname, totalScore: user.totalScore, userId: user.userId, userIcon: iconName))
                            }
                        case let .failure(error):
                            print("Failed to fetch user icon: \(error.localizedDescription)")
                        }
                    }
                }
            case let .failure(error):
                print("Failed to fetch leaderboard: \(error.localizedDescription)")
            }
        }
    }
}
