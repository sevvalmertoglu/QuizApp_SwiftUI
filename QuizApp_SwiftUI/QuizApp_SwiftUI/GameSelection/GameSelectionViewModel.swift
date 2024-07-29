//
//   NumberOfQuestionsViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation
import SwiftUI
import CoreAPI

@MainActor final class GameSelectionViewModel: ObservableObject {
        @Published var selectedDifficulty: Difficulty
        @Published var selectedType: TriviaType
        @Published var numberOfQuestions: Int
        @Published var errorMessage: String = ""
        @Published var questions: Array<Question> = []
        @Published var successfulLoad: Bool = false
        
        private let triviaCategory: TriviaCategory
        private let triviaService = TriviaService()
        
        private let updateAnimation = Animation.easeOut(duration: 0.25)
        
        // MARK: -- Constructors
        init(triviaCategory: TriviaCategory) {
            self.triviaCategory = triviaCategory
            self.selectedDifficulty = .any
            self.selectedType = .both
            self.numberOfQuestions = 10
        }

        // MARK: -- Methods
        public func updateDifficulty(selected: Difficulty) {
            withAnimation(updateAnimation) {
                self.selectedDifficulty = selected
            }
        }
        
        public func updateTriviaType(selected: TriviaType) {
            withAnimation(updateAnimation) {
                self.selectedType = selected
            }
        }
        
        public func updateQuantity(selected: Int) {
            withAnimation(updateAnimation) {
                self.numberOfQuestions = selected
            }
        }
        
        public func isDifficultyActive(_ difficulty: Difficulty) -> Bool {
            return difficulty == self.selectedDifficulty
        }
        
        public func isTriviaTypeActive(_ triviaType: TriviaType) -> Bool {
            return triviaType == self.selectedType
        }
        
        public func isQuantitySelected(_ number: Int) -> Bool {
            return number == self.numberOfQuestions
        }
        
        public func fetchTriviaQuestions() async {
            let (questions, error) = await triviaService.fetchTriviaQuestions(
                difficulty: self.selectedDifficulty,
                category: self.triviaCategory,
                triviaType: self.selectedType,
                quantity: self.numberOfQuestions
            )
            if let error = error {
                print("Error obtaining data.")
                errorMessage = error
                return
            }
            if questions.isEmpty {
                errorMessage = "There are not that many questions."
                return
            }
            print("Successfully obtained data.")
            self.questions = questions
            self.successfulLoad = true
        }
    }

