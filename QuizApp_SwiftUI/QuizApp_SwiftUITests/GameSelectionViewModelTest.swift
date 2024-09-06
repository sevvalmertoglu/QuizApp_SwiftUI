//
//  GameSelectionViewModelTest.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 6.09.2024.
//

@testable import QuizApp_SwiftUI
import XCTest

final class GameSelectionViewModelTest: XCTestCase {
    private var gameSelectionViewModel: GameSelectionViewModel!
    private var mockTriviaService: MockTriviaService!

    @MainActor
    override func setUp() {
        super.setUp()
        self.mockTriviaService = MockTriviaService()
        self.gameSelectionViewModel = GameSelectionViewModel(triviaCategory: TriviaCategory(id: 9, name: "General Knowledge"))
        self.gameSelectionViewModel.triviaService = self.mockTriviaService
    }

    override func tearDown() {
        self.gameSelectionViewModel = nil
        self.mockTriviaService = nil
        super.tearDown()
    }

    @MainActor
    func test_updateDifficulty() {
        self.gameSelectionViewModel.updateDifficulty(selected: .easy)
        XCTAssertEqual(self.gameSelectionViewModel.selectedDifficulty, .easy)
    }

    @MainActor
    func test_updateTriviaType() {
        self.gameSelectionViewModel.updateTriviaType(selected: .multipleChoice)
        XCTAssertEqual(self.gameSelectionViewModel.selectedType, .multipleChoice)
    }

    @MainActor
    func test_updateQuantity() {
        self.gameSelectionViewModel.updateQuantity(selected: 15)
        XCTAssertEqual(self.gameSelectionViewModel.numberOfQuestions, 15)
    }

    func test_fetchCategories_Success() async {
        self.mockTriviaService.mockCategories = [TriviaCategory(id: 10, name: "Movies"), TriviaCategory(id: 11, name: "Music")]

        let (categories, error) = await gameSelectionViewModel.triviaService.fetchCategories()

        XCTAssertNil(error)
        XCTAssertEqual(categories.count, 2)
        XCTAssertEqual(categories.first?.name, "Movies")
    }

    func test_fetchCategories_Error() async {
        self.mockTriviaService.mockError = "Failed to load categories"

        let (categories, error) = await gameSelectionViewModel.triviaService.fetchCategories()

        XCTAssertEqual(error, "Failed to load categories")
        XCTAssertTrue(categories.isEmpty)
    }

    @MainActor
    func test_isDifficultyActive() {
        let difficulty: Difficulty = .easy
        self.gameSelectionViewModel.updateDifficulty(selected: difficulty)

        XCTAssertTrue(self.gameSelectionViewModel.isDifficultyActive(.easy), "Difficulty should be active.")
        XCTAssertFalse(self.gameSelectionViewModel.isDifficultyActive(.hard), "Difficulty should not be active.")
    }

    @MainActor
    func test_isTriviaTypeActive() {
        let triviaType: TriviaType = .multipleChoice
        self.gameSelectionViewModel.updateTriviaType(selected: triviaType)

        XCTAssertTrue(self.gameSelectionViewModel.isTriviaTypeActive(.multipleChoice), "TriviaType should be active.")
        XCTAssertFalse(self.gameSelectionViewModel.isTriviaTypeActive(.trueFalse), "TriviaType should not be active.")
    }

    @MainActor
    func test_isQuantitySelected() {
        let quantity = 20
        self.gameSelectionViewModel.updateQuantity(selected: quantity)

        XCTAssertTrue(self.gameSelectionViewModel.isQuantitySelected(20), "Quantity should be active.")
        XCTAssertFalse(self.gameSelectionViewModel.isQuantitySelected(10), "Quantity should not be active.")
    }

    @MainActor
    func test_fetchTriviaQuestions_Success() async {
        let mockService = MockTriviaService()
        // Mock data
        let sampleQuestion = Question()
        sampleQuestion.category = "General Knowledge"
        sampleQuestion.type = "multiple"
        sampleQuestion.difficulty = "easy"
        sampleQuestion.question = "Sample question?"
        sampleQuestion.correct_answer = "Sample answer"
        sampleQuestion.incorrect_answers = ["Wrong answer 1", "Wrong answer 2"]

        mockService.mockQuestions = [sampleQuestion]

        self.gameSelectionViewModel.triviaService = mockService

        await self.gameSelectionViewModel.fetchTriviaQuestions()

        XCTAssertTrue(self.gameSelectionViewModel.successfulLoad, "The questions should be successfully loaded.")
        XCTAssertEqual(self.gameSelectionViewModel.questions.count, 1, "There should be one question loaded.")
        XCTAssertEqual(self.gameSelectionViewModel.questions.first?.question, "Sample question?", "The question should match the expected question.")
    }

    @MainActor
    func test_fetchTriviaQuestions_Error() async {
        let mockService = MockTriviaService()
        mockService.mockError = "Failed to fetch questions"

        self.gameSelectionViewModel.triviaService = mockService

        await self.gameSelectionViewModel.fetchTriviaQuestions()

        XCTAssertFalse(self.gameSelectionViewModel.successfulLoad, "The loading should not be successful.")
        XCTAssertEqual(self.gameSelectionViewModel.errorMessage, "Failed to fetch questions", "The error message should be set correctly.")
    }
}
