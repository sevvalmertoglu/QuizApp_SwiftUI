//
//  File.swift
//  
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//


import Foundation

public enum Difficulty: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    case any = "any"
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
        self.category = "Geography"
        self.type = "multiple"
        self.difficulty = "medium"
        self.question = "Which country inside the United Kingdom does NOT appear on its flag, the Union Jack?"
        self.correct_answer = "Wales"
        self.incorrect_answers = ["Scotland", "Ireland", "Isle of Wight"]
    }
    
    public func decodeBase64Strings() {
        if let decodedCategory = decodeBase64(string: self.category) {
            self.category = decodedCategory
        }
        
        if let decodedType = decodeBase64(string: self.type) {
            self.type = decodedType
        }
        
        if let decodedDifficulty = decodeBase64(string: self.difficulty) {
            self.difficulty = decodedDifficulty
        }
        
        if let decodedQuestion = decodeBase64(string: self.question) {
            self.question = decodedQuestion
        }
        
        if let decodedCorrectAnswer = decodeBase64(string: self.correct_answer) {
            self.correct_answer = decodedCorrectAnswer
        }
        
        for i in 0..<self.incorrect_answers.count {
            if let decodedIncorrectAnswer = decodeBase64(string: self.incorrect_answers[i]) {
                self.incorrect_answers[i] = decodedIncorrectAnswer
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

