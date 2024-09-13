//
//  QuestionsViewUITest.swift
//  QuizApp_SwiftUIUITests
//
//  Created by Şevval Mertoğlu on 12.09.2024.
//

import XCTest

final class QuestionsViewUITest: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        self.app = XCUIApplication()
        self.app.launch()
    }

    func testQuestionsViewDisplaysAndNavigatesCorrectly() throws {
        let searchField = self.app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("Geography")

        let categoryLabel = self.app.buttons["Geography"]
        XCTAssertTrue(categoryLabel.exists)
        categoryLabel.tap()

        let easyButton = self.app.buttons["Easy"]
        XCTAssertTrue(easyButton.exists)
        easyButton.tap()

        let multipleChoiceButton = self.app.buttons["Multiple Choice"]
        multipleChoiceButton.tap()

        let removeButton = self.app.buttons["Remove"]
        for _ in 0..<7 {
            removeButton.tap()
        }

        let startButton = self.app.buttons["Start!"]
        XCTAssertTrue(startButton.exists)
        startButton.tap()

        let startTime = self.app.staticTexts["10"]
        XCTAssertTrue(startTime.waitForExistence(timeout: 1))
        let clockImage = self.app.images["Clock"]
        XCTAssertTrue(clockImage.exists)

        for i in 1...3 {
            // To Check Question Number
            let questionIndexLabel = self.app.staticTexts["\(i) / 3"]
            XCTAssertTrue(questionIndexLabel.waitForExistence(timeout: 5), "Question \(i) did not load in time.")

            // Chooses a random answer for each question
            let firstAnswer = self.app.buttons.element(boundBy: 0)
            XCTAssertTrue(firstAnswer.exists, "First answer option for question \(i) does not exist.")
            firstAnswer.tap()

            // To Move On To The Next Question
            if i < 3 {
                let nextQuestionIndexLabel = self.app.staticTexts["\(i + 1) / 3"]
                XCTAssertTrue(nextQuestionIndexLabel.waitForExistence(timeout: 5), "Next question \(i + 1) did not load in time.")
            }
        }
        let gameOverLabel = self.app.staticTexts["GAME OVER!"]
        XCTAssertTrue(gameOverLabel.waitForExistence(timeout: 5), "Game Over screen did not appear after the last question.")

        let playAgainButton = self.app.buttons["Play Again"]
        XCTAssertTrue(playAgainButton.exists, "The Play Again button should be visible on the GAME OVER screen")
        playAgainButton.tap()

        let navigationLabel = self.app.navigationBars["Geography"]
        XCTAssertTrue(navigationLabel.exists, "The app should navigate back to the Geography screen.")
    }
}
