//
//  ProfileSettingsViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 16.08.2024.
//

import SwiftUI
import UIKit

class ProfileSettingsViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var userIcon: UIImage? = nil
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    func fetchUserProfile(userId: String) {
        FirebaseManager.shared.fetchUserData(userId: userId) { [weak self] result in
            switch result {
            case let .success(user):
                DispatchQueue.main.async {
                    self?.name = user.name
                    self?.nickname = user.nickname
                }
                self?.fetchUserIcon(userId: userId)
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }

    func fetchUserIcon(userId: String) {
        FirebaseManager.shared.fetchUserIcon(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(iconName):
                    self?.userIcon = UIImage(named: iconName)
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }

    func saveProfileChanges(userId: String) {
        FirebaseManager.shared.updateUserProfile(userId: userId, name: self.name, nickname: self.nickname) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.alertMessage = "Profile information saved successfully!"
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                }
                self?.showAlert = true
            }
        }
    }
}
