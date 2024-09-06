//
//  TriviaAPIEndpointTest.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 6.09.2024.
//

@testable import QuizApp_SwiftUI
import XCTest

class TriviaAPIEndpointTest: XCTestCase {
    func testFetchTriviaQuestionsPath_withDifficultyAndType() {
        // Test: Question request with difficulty and triviaType
        let endpoint = TriviaAPI.fetchTriviaQuestions(
            difficulty: .easy,
            category: TriviaCategory(id: 1, name: "Science"),
            triviaType: .multipleChoice,
            quantity: 10
        )

        XCTAssertEqual(endpoint.baseUrl, "https://opentdb.com/", "Base URL is incorrect")
        XCTAssertEqual(endpoint.path, "api.php?amount=10&category=1&difficulty=easy&type=multiple&encode=base64", "Path is incorrect")
        XCTAssertEqual(endpoint.method, .get, "HTTP method is incorrect")
    }

    func testFetchTriviaQuestionsPath_withAnyDifficultyAndBothType() {
        // Test: Difficulty is 'any' and triviaType is 'both'
        let endpoint = TriviaAPI.fetchTriviaQuestions(
            difficulty: .any,
            category: TriviaCategory(id: 2, name: "History"),
            triviaType: .both,
            quantity: 5
        )

        XCTAssertEqual(endpoint.baseUrl, "https://opentdb.com/", "Base URL is incorrect")
        XCTAssertEqual(endpoint.path, "api.php?amount=5&category=2&encode=base64", "Path is incorrect")
        XCTAssertEqual(endpoint.method, .get, "HTTP method is incorrect")
    }

    func testFetchCategoriesPath() {
        // Test: Category request
        let endpoint = TriviaAPI.fetchCategories

        XCTAssertEqual(endpoint.baseUrl, "https://opentdb.com/", "Base URL is incorrect")
        XCTAssertEqual(endpoint.path, "api_category.php", "Path is incorrect")
        XCTAssertEqual(endpoint.method, .get, "HTTP method is incorrect")
    }
}
