//
//  QuestionsViewModelTest.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 6.09.2024.
//

@testable import QuizApp_SwiftUI
import XCTest

class QuestionsViewModelTest: XCTestCase {
    var viewModel: QuestionsViewModel!
    var mockFirebaseManager: MockFirebaseManager!

    override func setUp() {
        super.setUp()
        self.mockFirebaseManager = MockFirebaseManager()
        FirebaseManager.shared = self.mockFirebaseManager
        self.viewModel = QuestionsViewModel()
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockFirebaseManager = nil
        super.tearDown()
    }

    // Test: Multiple Choice
    func test_whenMultipleChoiceQuestionInitialized_shouldReturnFourPossibleAnswers() {
        let question = Question()
        question.correct_answer = "Wales"
        question.incorrect_answers = ["Scotland", "Ireland", "Isle of Wight"]
        question.type = TriviaType.multipleChoice.rawValue

        let possibilities = self.viewModel.initPossiblities(question: question)

        XCTAssertEqual(possibilities.count, 4, "Expected 4 possible answers, but got \(possibilities.count)")
        XCTAssertTrue(possibilities.contains { $0.text == "Wales" && !$0.incorrect }, "Correct answer not found in possibilities")
    }

    // Test: True/False
    func test_whenTrueFalseQuestionInitialized_shouldReturnTwoPossibleAnswers() {
        let question = Question()
        question.correct_answer = "True"
        question.incorrect_answers = ["False"]
        question.type = TriviaType.trueFalse.rawValue

        let possibilities = self.viewModel.initPossiblities(question: question)

        XCTAssertEqual(possibilities.count, 2, "Expected 2 possible answers, but got \(possibilities.count)")
        XCTAssertTrue(possibilities.contains { $0.text == "True" && !$0.incorrect }, "Correct answer 'True' not found")
        XCTAssertTrue(possibilities.contains { $0.text == "False" && $0.incorrect }, "Incorrect answer 'False' not found")
    }

    // Test: Successfully save score to Firebase
    func test_whenSaveScoreToFirebaseSucceeds_shouldCallSaveScore() {
        self.mockFirebaseManager.saveScoreResult = .success(()) // Set mock to return a successful response
        self.viewModel.correctCount = 5

        self.viewModel.saveScoreToFirebase()

        XCTAssertTrue(self.mockFirebaseManager.saveScoreResult != nil, "saveScore should have been called")
    }

    // Test: Failure to register points
    func test_whenSaveScoreToFirebaseFails_shouldHandleFailureGracefully() {
        self.mockFirebaseManager.saveScoreResult = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock save score error"]))
        self.viewModel.correctCount = 3

        self.viewModel.saveScoreToFirebase()

        XCTAssertTrue(self.mockFirebaseManager.saveScoreResult != nil, "saveScore should have been called")
    }
}
