//
//  PreviousScoresViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 1.08.2024.
//

import FirebaseAuth
import FirebaseDatabase
import Foundation

class PreviousScoresViewModel: ObservableObject {
    @Published var scores: [Score] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchScores() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not logged in."
            return
        }

        self.isLoading = true

        FirebaseManager.shared.fetchScores(forUserId: userId) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case let .success(fetchedScores):
                    self.scores = fetchedScores
                case let .failure(error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
