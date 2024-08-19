//
//  LeaderRankingViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 13.08.2024.
//

import Foundation

class LeaderRankingViewModel: ObservableObject {
    @Published var otherUsers: [(nickname: String, totalScore: Int, userId: String, userIcon: String)] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    private let firebaseManager = FirebaseManager.shared

    init() {
        self.observeOtherUsers()
    }

    func observeOtherUsers() {
        self.isLoading = true
        self.firebaseManager.fetchLeaderboard { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            switch result {
            case let .success(leaderboard):
                DispatchQueue.main.async {
                    let sortedLeaderboard = leaderboard.sorted { $0.totalScore > $1.totalScore }
                    self?.otherUsers = sortedLeaderboard.dropFirst(3).prefix(7).map { user in
                        (nickname: user.nickname, totalScore: user.totalScore, userId: user.userId, userIcon: "")
                    }
                    self?.fetchUserDataForOtherUsers()
                    self?.fetchIconsForOtherUsers()
                }
            case let .failure(error):
                print("Failed to observe leaderboard changes: \(error.localizedDescription)")
            }
        }
    }

    func fetchUserDataForOtherUsers() {
        for (index, user) in self.otherUsers.enumerated() {
            FirebaseManager.shared.fetchUserData(userId: user.userId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(fetchedUser):
                        self?.otherUsers[index].nickname = fetchedUser.nickname
                    case let .failure(error):
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                    }
                }
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
