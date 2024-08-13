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

    init() {
        self.observeOtherUsers()
    }

    func observeOtherUsers() {
        self.firebaseManager.fetchLeaderboard { [weak self] result in
            switch result {
            case let .success(leaderboard):
                DispatchQueue.main.async {
                    let sortedLeaderboard = leaderboard.sorted { $0.totalScore > $1.totalScore }
                    self?.otherUsers = sortedLeaderboard.dropFirst(3).prefix(7).map { user in
                        (nickname: user.nickname, totalScore: user.totalScore, userId: user.userId, userIcon: "")
                    }
                    self?.fetchIconsForOtherUsers()
                }
            case let .failure(error):
                print("Failed to observe leaderboard changes: \(error.localizedDescription)")
            }
        }
    }

    private func fetchIconsForOtherUsers() {
        for (index, user) in self.otherUsers.enumerated() {
            self.firebaseManager.fetchUserIcon(userId: user.userId) { [weak self] result in
                switch result {
                case let .success(iconName):
                    DispatchQueue.main.async {
                        self?.otherUsers[index].userIcon = iconName
                    }
                case let .failure(error):
                    print("Failed to observe user icon changes: \(error.localizedDescription)")
                }
            }
        }
    }
}
