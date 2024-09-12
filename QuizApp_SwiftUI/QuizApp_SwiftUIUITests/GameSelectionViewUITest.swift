//
//  GameSelectionViewUITest.swift
//  QuizApp_SwiftUIUITests
//
//  Created by Şevval Mertoğlu on 11.09.2024.
//

import XCTest

final class GameSelectionViewUITest: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        self.app = XCUIApplication()
        self.app.launch()
    }

    func testDifficultySelection() throws {
        let categoryText = self.app.buttons["General Knowledge"]
        XCTAssertTrue(categoryText.exists)
        categoryText.tap()

        let navigationBar = self.app.navigationBars["General Knowledge"]
        XCTAssertTrue(navigationBar.exists)

        let difficultyText = self.app.staticTexts["Difficulty"]
        XCTAssertTrue(difficultyText.exists)

        // Select "Easy" difficulty and ensure it's selected
        let easyButton = self.app.buttons["Easy"]
        XCTAssertTrue(easyButton.exists)
        easyButton.tap()

        // Check that it is selected with "accessibilityValue"
        XCTAssertEqual(easyButton.value as! String, "Selected")

        // Ensure other difficulties are not selected
        let anyButton = self.app.buttons["Any"]
        XCTAssertTrue(anyButton.exists)
        XCTAssertEqual(anyButton.value as! String, "Not Selected")

        let mediumButton = self.app.buttons["Medium"]
        XCTAssertTrue(mediumButton.exists)
        XCTAssertEqual(mediumButton.value as! String, "Not Selected")

        let hardButton = self.app.buttons["Hard"]
        XCTAssertTrue(hardButton.exists)
        XCTAssertEqual(hardButton.value as! String, "Not Selected")
    }

    func testQuestionTypeSelection() throws {
        let categoryText = self.app.buttons["General Knowledge"]
        XCTAssertTrue(categoryText.exists)
        categoryText.tap()

        let navigationBar = self.app.navigationBars["General Knowledge"]
        XCTAssertTrue(navigationBar.exists)

        let questionTypeText = self.app.staticTexts["Question Type"]
        XCTAssertTrue(questionTypeText.exists)

        // Select "Multiple Choice" and ensure it's selected
        let multipleChoiceButton = self.app.buttons["Multiple Choice"]
        multipleChoiceButton.tap()
        XCTAssertEqual(multipleChoiceButton.value as! String, "Selected")

        // Ensure other question types are not selected
        let bothButton = self.app.buttons["Both"]
        XCTAssertEqual(bothButton.value as! String, "Not Selected")

        let trueFalseButton = self.app.buttons["True / False"]
        XCTAssertEqual(trueFalseButton.value as! String, "Not Selected")
    }

    func testNumberOfQuestionsStepper() throws {
        let categoryText = self.app.buttons["General Knowledge"]
        XCTAssertTrue(categoryText.exists)
        categoryText.tap()

        let navigationBar = self.app.navigationBars["General Knowledge"]
        XCTAssertTrue(navigationBar.exists)

        let numberOfQuestionsText = self.app.staticTexts["Number of questions"]
        XCTAssertTrue(numberOfQuestionsText.exists)

        // Find the stepper and increment the value
        let addButton = self.app.buttons["Add"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()

        let initialValue = self.app.staticTexts["11"]
        XCTAssertTrue(initialValue.exists)

        let removeButton = self.app.buttons["Remove"]
        removeButton.tap()

        // Verify the new stepper value
        let newValue = self.app.staticTexts["10"]
        XCTAssertTrue(newValue.exists)
    }

    func testStartButton() throws {
        let categoryText = self.app.buttons["General Knowledge"]
        XCTAssertTrue(categoryText.exists)
        categoryText.tap()

        let navigationBar = self.app.navigationBars["General Knowledge"]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5))

        let removeButton = self.app.buttons["Remove"]
        removeButton.tap()

        let startButton = self.app.buttons["Start!"]
        XCTAssertTrue(startButton.exists)

        // Tap the "Start!" button
        startButton.tap()

        let timeStart = self.app.staticTexts["10"]
        XCTAssertTrue(timeStart.exists)
    }
}
