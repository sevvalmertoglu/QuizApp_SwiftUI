//
//  TriviaServiceTest.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 6.09.2024.
//

@testable import QuizApp_SwiftUI
import XCTest

class TriviaServiceTests: XCTestCase {
    var mockTriviaService: MockTriviaService!

    override func setUp() {
        super.setUp()
        self.mockTriviaService = MockTriviaService()
    }

    override func tearDown() {
        self.mockTriviaService = nil
        super.tearDown()
    }

    func testFetchTriviaQuestionsSuccess() async {
        let question = Question()
        let mockQuestions = [question]
        self.mockTriviaService.mockQuestions = mockQuestions
        self.mockTriviaService.mockError = nil

        let (questions, error) = await mockTriviaService.fetchTriviaQuestions(
            difficulty: .easy,
            category: TriviaCategory(id: 1, name: "Science"),
            triviaType: .multipleChoice,
            quantity: 1
        )

        XCTAssertNil(error, "Expected no error, but got: \(String(describing: error))")
        XCTAssertEqual(questions.count, 1, "Expected 1 question, but got \(questions.count)")
        XCTAssertEqual(questions.first?.question, question.question, "Expected question text to match")
    }

    func testFetchTriviaQuestionsFailure() async {
        let mockError = "Failed to fetch questions"
        self.mockTriviaService.mockQuestions = []
        self.mockTriviaService.mockError = mockError

        let (questions, error) = await mockTriviaService.fetchTriviaQuestions(
            difficulty: .hard,
            category: TriviaCategory(id: 2, name: "History"),
            triviaType: .trueFalse,
            quantity: 1
        )

        XCTAssertNotNil(error, "Expected an error, but got nil")
        XCTAssertEqual(error, mockError, "Expected error to match \(mockError), but got \(String(describing: error))")
        XCTAssertTrue(questions.isEmpty, "Expected no questions, but got \(questions.count)")
    }

    func testFetchCategoriesSuccess() async {
        let category = TriviaCategory(id: 1, name: "Science")
        let mockCategories = [category]
        self.mockTriviaService.mockCategories = mockCategories
        self.mockTriviaService.mockError = nil

        let (categories, error) = await mockTriviaService.fetchCategories()

        XCTAssertNil(error, "Expected no error, but got: \(String(describing: error))")
        XCTAssertEqual(categories.count, 1, "Expected 1 category, but got \(categories.count)")
        XCTAssertEqual(categories.first?.name, category.name, "Expected category name to match")
    }

    func testFetchCategoriesFailure() async {
        let mockError = "Failed to fetch categories"
        self.mockTriviaService.mockCategories = []
        self.mockTriviaService.mockError = mockError

        let (categories, error) = await mockTriviaService.fetchCategories()

        XCTAssertNotNil(error, "Expected an error, but got nil")
        XCTAssertEqual(error, mockError, "Expected error to match \(mockError), but got \(String(describing: error))")
        XCTAssertTrue(categories.isEmpty, "Expected no categories, but got \(categories.count)")
    }
}
