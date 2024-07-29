//
//  QuestionsViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import Foundation
import CoreAPI

class QuestionsViewModel: ObservableObject {
    @Published var correctCount: Int = 0
    @Published var incorrectCount: Int = 0
    
    public func initPossiblities(question: Question) -> Array<Answer> {
        if question.type == TriviaType.multipleChoice.rawValue {
            return initMultipleChoice(question: question)
        }
        return initTrueFalse(question: question)
    }
    
    private func initMultipleChoice(question: Question) -> Array<Answer> {
        var possibilities: Array<Answer> = []
        let correctAnswer = Answer(question.correct_answer, incorrect: false)
        possibilities.append(correctAnswer)
        for incorrectAnswer in question.incorrect_answers {
            possibilities.append(Answer(incorrectAnswer, incorrect: true))
        }
        possibilities.shuffle()
        return possibilities
    }
    
    private func initTrueFalse(question: Question) -> Array<Answer> {
        var possibilities: Array<Answer> = []
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

