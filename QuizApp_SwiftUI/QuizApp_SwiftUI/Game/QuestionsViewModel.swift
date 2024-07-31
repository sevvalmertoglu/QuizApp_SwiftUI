//
//  QuestionsViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import CoreAPI
import Foundation

class QuestionsViewModel: ObservableObject {
    @Published var correctCount: Int = 0
    @Published var incorrectCount: Int = 0

    public func initPossiblities(question: Question) -> [Answer] {
        if question.type == TriviaType.multipleChoice.rawValue {
            return self.initMultipleChoice(question: question)
        }
        return self.initTrueFalse(question: question)
    }

    private func initMultipleChoice(question: Question) -> [Answer] {
        var possibilities: [Answer] = []
        let correctAnswer = Answer(question.correct_answer, incorrect: false)
        possibilities.append(correctAnswer)
        for incorrectAnswer in question.incorrect_answers {
            possibilities.append(Answer(incorrectAnswer, incorrect: true))
        }
        possibilities.shuffle()
        return possibilities
    }

    private func initTrueFalse(question: Question) -> [Answer] {
        var possibilities: [Answer] = []
        if question.correct_answer == "True" {
            possibilities.append(Answer("True", incorrect: false))
            possibilities.append(Answer("False", incorrect: true))
        } else {
            possibilities.append(Answer("True", incorrect: true))
            possibilities.append(Answer("False", incorrect: false))
        }
        return possibilities
    }
}
