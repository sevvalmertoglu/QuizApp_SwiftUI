//
//  File.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import CoreAPI
import Foundation

enum TriviaAPI {
    case fetchTriviaQuestions(difficulty: Difficulty, category: TriviaCategory, triviaType: TriviaType, quantity: Int)
    case fetchCategories
}

extension TriviaAPI: Endpoint {
    var baseUrl: String {
        return "https://opentdb.com/"
    }

    var path: String {
        switch self {
        case .fetchTriviaQuestions(let difficulty, let category, let triviaType, let quantity):
            var urlString = "api.php?amount=\(quantity)&category=\(category.id)"
            if difficulty != .any {
                urlString += "&difficulty=\(difficulty.rawValue)"
            }
            if triviaType != .both {
                urlString += "&type=\(triviaType.rawValue)"
            }
            urlString += "&encode=base64"
            return urlString
        case .fetchCategories:
            return "api_category.php"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchTriviaQuestions, .fetchCategories:
            return .get
        }
    }

    var parameters: [String: Any] {
        return [:]
    }
}
