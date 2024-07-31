//
//  Question.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import Foundation

public enum Difficulty: String {
    case easy
    case medium
    case hard
    case any
}

public enum TriviaType: String {
    case multipleChoice = "multiple"
    case trueFalse = "boolean"
    case both = ""
}

public class Question: Decodable {
    public var category: String
    public var type: String
    public var difficulty: String
    public var question: String
    public var correct_answer: String
    public var incorrect_answers: [String]

    public init() {
        category = "Geography"
        type = "multiple"
        difficulty = "medium"
        question = "Which country inside the United Kingdom does NOT appear on its flag, the Union Jack?"
        correct_answer = "Wales"
        incorrect_answers = ["Scotland", "Ireland", "Isle of Wight"]
    }

    public func decodeBase64Strings() {
        if let decodedCategory = decodeBase64(string: category) {
            category = decodedCategory
        }

        if let decodedType = decodeBase64(string: type) {
            type = decodedType
        }

        if let decodedDifficulty = decodeBase64(string: difficulty) {
            difficulty = decodedDifficulty
        }

        if let decodedQuestion = decodeBase64(string: question) {
            question = decodedQuestion
        }

        if let decodedCorrectAnswer = decodeBase64(string: correct_answer) {
            correct_answer = decodedCorrectAnswer
        }

        for i in 0 ..< incorrect_answers.count {
            if let decodedIncorrectAnswer = decodeBase64(string: incorrect_answers[i]) {
                incorrect_answers[i] = decodedIncorrectAnswer
            }
        }
    }

    private func decodeBase64(string: String) -> String? {
        if let stringData = Data(base64Encoded: string) {
            if let decodedString = String(data: stringData, encoding: .utf8) {
                return decodedString
            }
        }
        return nil
    }
}

public class QuestionsDecodable: Decodable {
    public let response_code: Int
    public let results: [Question]

    public init(response_code: Int, results: [Question]) {
        self.response_code = response_code
        self.results = results
    }
}
