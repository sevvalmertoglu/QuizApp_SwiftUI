//
//  Quiz.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation

extension String {
    /// Converts HTML string to a `NSAttributedString`

    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}

struct QuizData: Decodable {
    var results: [QuestionData]
    var response_code: Int
}

struct QuestionData: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
