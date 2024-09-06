//
//  MockTriviaService.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 6.09.2024.
//

@testable import QuizApp_SwiftUI
import Foundation

class MockTriviaService: TriviaService {
    var mockCategories: [TriviaCategory] = []
    var mockQuestions: [Question] = []
    var mockError: String?

    override func fetchCategories() async -> (categories: [TriviaCategory], error: String?) {
        return (self.mockCategories, self.mockError)
    }

    override func fetchTriviaQuestions(difficulty: Difficulty, category: TriviaCategory, triviaType: TriviaType, quantity: Int) async -> (questions: [Question], error: String?) {
        if let error = mockError {
            return ([], error)
        }
        return (self.mockQuestions, nil)
    }
}
