//
//   AuthViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var isSignedIn: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false

    private var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func signIn() {
        guard !self.email.isEmpty, !self.password.isEmpty else {
            self.alertMessage = "Please fill in the email and password fields."
            self.showAlert = true
            return
        }
        self.isLoading = true
        FirebaseManager.shared.signIn(email: self.email, password: self.password) { [weak self] result in
            DispatchQueue.main.async { // UI updates are done in the main thread
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isSignedIn = true
                    self?.appState.isUserLoggedIn = true
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }

    func register() {
        self.isLoading = true
        FirebaseManager.shared.register(email: self.email, password: self.password, name: self.name, nickname: self.nickname) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isSignedIn = true
                    self?.appState.isUserLoggedIn = true
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
            self.isSignedIn = false
            self.appState.isUserLoggedIn = false
        } catch {
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
}
