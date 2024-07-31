//
//  TriviaService.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 29.07.2024.
//

import Alamofire
import CoreAPI
import Foundation

public class TriviaService {
    private let networkManager = NetworkManager<TriviaAPI>()

    public init() {}

    public func fetchTriviaQuestions(difficulty: Difficulty, category: TriviaCategory, triviaType: TriviaType, quantity: Int) async -> (questions: [Question], error: String?) {
        await withCheckedContinuation { continuation in
            networkManager.request(endpoint: .fetchTriviaQuestions(difficulty: difficulty, category: category, triviaType: triviaType, quantity: quantity), type: QuestionsDecodable.self) { result in
                switch result {
                case let .success(response):
                    let questions = response.results
                    for question in questions {
                        question.decodeBase64Strings()
                    }
                    continuation.resume(returning: (questions, nil))
                case let .failure(error):
                    continuation.resume(returning: ([], error.message))
                }
            }
        }
    }

    public func fetchCategories() async -> (categories: [TriviaCategory], error: String?) {
        await withCheckedContinuation { continuation in
            networkManager.request(endpoint: .fetchCategories, type: TriviaCategories.self) { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: (response.trivia_categories, nil))
                case let .failure(error):
                    continuation.resume(returning: ([], error.message))
                }
            }
        }
    }
}
