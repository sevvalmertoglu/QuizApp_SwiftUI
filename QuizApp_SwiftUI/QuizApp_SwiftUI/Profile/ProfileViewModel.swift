//
//  ProfileViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 1.08.2024.
//
import FirebaseAuth
import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var totalScore: Int = 0
    @Published var userIcon: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showConfirmationDialog: Bool = false

    var appState: AppState

    init(appState: AppState) {
        self.appState = appState
        self.fetchUserData()
    }

    func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.alertMessage = "User not logged in."
            self.showAlert = true
            return
        }

        self.isLoading = true
        FirebaseManager.shared.fetchUserData(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case let .success(user):
                    self?.name = user.name
                    self?.nickname = user.nickname
                    self?.email = user.email
                    self?.totalScore = self?.calculateTotalScore(from: user.Scores) ?? 0
                    self?.fetchSelectedUserIcon(userId: userId)
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }

    private func calculateTotalScore(from scores: [Score]) -> Int {
        return scores.reduce(0) { $0 + $1.score }
    }

    func fetchSelectedUserIcon(userId: String) {
        FirebaseManager.shared.fetchUserIcon(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(iconName):
                    self?.userIcon = UIImage(named: iconName) // Load the image from assets
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }

    func logOut() {
        do {
            try FirebaseManager.shared.signOut()
            self.appState.isUserLoggedIn = false
        } catch {
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }

    func deleteUserAccount() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.alertMessage = "No user is logged in."
            self.showAlert = true
            return
        }

        self.isLoading = true

        FirebaseManager.shared.deleteUserData(userId: userId) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                    self?.isLoading = false
                } else {
                    // Attempt to delete the user from Firebase
                    if let currentUser = Auth.auth().currentUser {
                        currentUser.delete { error in
                            DispatchQueue.main.async {
                                self?.isLoading = false
                                if let error = error {
                                    self?.alertMessage = error.localizedDescription
                                    self?.showAlert = true
                                } else {
                                    self?.appState.isUserLoggedIn = false
                                }
                            }
                        }
                    } else {
                        self?.alertMessage = "No user is logged in."
                        self?.showAlert = true
                        self?.isLoading = false
                    }
                }
            }
        }
    }

    func resetPassword() {
        guard let email = Auth.auth().currentUser?.email else { return }
        isLoading = true
        FirebaseManager.shared.resetPassword(email: email) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.alertMessage = "Password reset email sent."
                case .failure(let error):
                    self?.alertMessage = error.localizedDescription
                }
                self?.showAlert = true
            }
        }
    }
}
