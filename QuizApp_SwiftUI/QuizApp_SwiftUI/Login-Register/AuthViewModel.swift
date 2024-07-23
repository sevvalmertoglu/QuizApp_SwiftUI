//
//   AuthViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var isSignedIn: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
        
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            self.alertMessage = "No email or password found."
            self.showAlert = true
            return
        }
        isLoading = true
        FirebaseManager.shared.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async { //UI updates are done in the main thread
                self?.isLoading = false
                switch result {
                case .success(_):
                    self?.isSignedIn = true
                case .failure(let error):
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }
    
    func register() {
        isLoading = true
        FirebaseManager.shared.register(email: email, password: password, name: name, nickname: nickname) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(_):
                    self?.isSignedIn = true
                case .failure(let error):
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }
    
    func logOut() throws {
        try FirebaseManager.shared.signOut()
    }
    
    
}




