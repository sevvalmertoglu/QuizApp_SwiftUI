//
//  LeaderBoardViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 12.08.2024.
//

import Foundation

class LeaderBoardViewModel: ObservableObject {
    @Published var topThreeUsers: [(nickname: String, totalScore: Int, userId: String, userIcon: String)] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    private let firebaseManager = FirebaseManager.shared

    init() {
        self.observeLeaderboardChanges()
    }

    func observeLeaderboardChanges() {
        self.isLoading = true
        self.firebaseManager.fetchLeaderboard { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            switch result {
            case let .success(leaderboard):
                DispatchQueue.main.async {
                    let sortedLeaderboard = leaderboard.sorted { $0.totalScore > $1.totalScore }
                    self?.topThreeUsers = sortedLeaderboard.prefix(3).map { user in
                        (nickname: user.nickname, totalScore: user.totalScore, userId: user.userId, userIcon: "")
                    }
                    self?.fetchUserDataForTopThree()
                    self?.fetchIconsForTopThreeUsers()
                }
            case let .failure(error):
                print("Failed to observe leaderboard changes: \(error.localizedDescription)")
            }
        }
    }

    func fetchUserDataForTopThree() {
        for (index, user) in self.topThreeUsers.enumerated() {
            FirebaseManager.shared.fetchUserData(userId: user.userId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(fetchedUser):
                        self?.topThreeUsers[index].nickname = fetchedUser.nickname
                    case let .failure(error):
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                    }
                }
            }
        }
    }

    private func fetchIconsForTopThreeUsers() {
        for (index, user) in self.topThreeUsers.enumerated() {
            self.firebaseManager.fetchUserIcon(userId: user.userId) { [weak self] result in
                switch result {
                case let .success(iconName):
                    DispatchQueue.main.async {
                        self?.topThreeUsers[index].userIcon = iconName
                    }
                case let .failure(error):
                    print("Failed to observe user icon changes: \(error.localizedDescription)")
                }
            }
        }
    }
}
