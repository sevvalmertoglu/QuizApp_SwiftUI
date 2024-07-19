//
//   AuthViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    var email: String = ""
    var password: String = ""
    var name: String = ""
    var nickname: String = ""
    var user: User?
    var errorMessage: String?
    var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func signIn() {
        isLoading = true
        FirebaseManager.shared.signIn(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { user in
                self.user = user
            }
            .store(in: &cancellables)
    }
    
    func register() {
        isLoading = true
        FirebaseManager.shared.register(email: email, password: password, name: name, nickname: nickname)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { user in
                self.user = user
            }
            .store(in: &cancellables)
    }
}

