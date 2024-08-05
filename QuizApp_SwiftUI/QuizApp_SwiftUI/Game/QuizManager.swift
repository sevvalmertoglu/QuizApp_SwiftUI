//
//  QuizManager.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 5.08.2024.
//

import Foundation

class QuizManager {
    private let viewModel: QuestionsViewModel
    private var currentQuestionIndex: Int = 0
    private var questions: [Question]

    init(viewModel: QuestionsViewModel, questions: [Question]) {
        self.viewModel = viewModel
        self.questions = questions
    }

    func handleAnswer(isCorrect: Bool) {
        if isCorrect {
            self.viewModel.correctCount += 1
        } else {
            self.viewModel.incorrectCount += 1
        }
        self.goToNextQuestion()
    }

    private func goToNextQuestion() {
        if self.currentQuestionIndex + 1 >= self.questions.count {
            self.viewModel.saveScoreToFirebase()
        } else {
            self.currentQuestionIndex += 1
        }
    }

    func currentQuestion() -> Question {
        return self.questions[self.currentQuestionIndex]
    }
}
