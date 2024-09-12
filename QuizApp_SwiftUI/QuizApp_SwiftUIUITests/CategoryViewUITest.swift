//
//  CategoryViewUITest.swift
//  QuizApp_SwiftUIUITests
//
//  Created by Şevval Mertoğlu on 11.09.2024.
//

import XCTest

final class CategoryViewUITest: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        self.app = XCUIApplication()
        self.app.launch()
    }

    func testInitialCategoryListLoads() throws {
        let selectCategoryText = self.app.staticTexts["Please select a category"]
        XCTAssertTrue(selectCategoryText.exists)

        // Checks if at least one category is loaded
        let categoryText = self.app.buttons["General Knowledge"]
        XCTAssertTrue(categoryText.exists)
    }

    func testSearchFunctionality() throws {
        let searchField = self.app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)

        searchField.tap()
        searchField.typeText("Science")

        // Ensure the filtered result appears
        let filteredCategoryText = self.app.buttons["Science & Nature"]
        XCTAssertTrue(filteredCategoryText.exists)

        // Ensure a non-matching category does not appear
        let nonMatchingCategoryText = self.app.buttons["General Knowledge"]
        XCTAssertFalse(nonMatchingCategoryText.exists)
    }

    func testCategorySelection() throws {
        let categoryText = self.app.buttons["General Knowledge"]
        XCTAssertTrue(categoryText.exists)
        categoryText.tap()

        // Check if navigation to GameSelectionView occurs
        let gameSelectionTitle = self.app.navigationBars["General Knowledge"]
        XCTAssertTrue(gameSelectionTitle.exists)
    }

    func testLightDarkModeToggle() throws {
        // Check if the light mode is initially enabled
        let lightModeButton = self.app.buttons["Brightness Higher"]
        XCTAssertTrue(lightModeButton.exists)

        lightModeButton.tap()
        // Check if the mode has changed
        let darkModeButton = self.app.buttons["Do Not Disturb"]
        XCTAssertTrue(darkModeButton.exists)

        darkModeButton.tap()
        XCTAssertTrue(lightModeButton.exists)
    }
}
