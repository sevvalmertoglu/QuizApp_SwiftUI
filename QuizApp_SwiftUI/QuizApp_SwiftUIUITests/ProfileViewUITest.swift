//
//  ProfileViewUITest.swift
//  QuizApp_SwiftUIUITests
//
//  Created by Şevval Mertoğlu on 13.09.2024.
//

@testable import QuizApp_SwiftUI // Your app's module name
import SwiftUI
import XCTest

class ProfileViewUITest: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        self.app = XCUIApplication()
        self.app.launch()
    }

    func testProfileViewUIElements() {
        self.app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let profileTitle = self.app.staticTexts["Profile"]
        let nameLabel = self.app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Name:'")).element
        let nicknameLabel = self.app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Nickname:'")).element
        let emailLabel = self.app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Mail:'")).element
        let totalScoreLabel = self.app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Total Score:'")).element
        let pencilButton = self.app.buttons["pencil.and.scribble"]
        let previousScoresButton = self.app.buttons["Previous Scores"]
        let logOutButton = self.app.buttons["Log Out"]
        let resetPasswordButton = self.app.buttons["Reset Password"]
        let deleteAccountButton = self.app.buttons["Delete Account"]

        XCTAssertTrue(profileTitle.waitForExistence(timeout: 5))
        XCTAssertTrue(nameLabel.waitForExistence(timeout: 5))
        XCTAssertTrue(nicknameLabel.waitForExistence(timeout: 5))
        XCTAssertTrue(emailLabel.waitForExistence(timeout: 5))
        XCTAssertTrue(totalScoreLabel.waitForExistence(timeout: 5))
        XCTAssertTrue(pencilButton.waitForExistence(timeout: 5))
        XCTAssertTrue(previousScoresButton.waitForExistence(timeout: 5))
        XCTAssertTrue(logOutButton.waitForExistence(timeout: 5))
        XCTAssertTrue(resetPasswordButton.waitForExistence(timeout: 5))
        XCTAssertTrue(deleteAccountButton.waitForExistence(timeout: 5))
    }

    func testNavigationToPreviousScores() {
        self.app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let previousScoresButton = self.app.buttons["Previous Scores"]
        XCTAssertTrue(previousScoresButton.exists, "Previous Scores button does not exist.")
        previousScoresButton.tap()

        let previousScoresViewTitle = self.app.navigationBars["Previous Scores"]
        XCTAssertTrue(previousScoresViewTitle.exists, "Failed to navigate to Previous Scores view.")
    }

    func testProfileSettingsNavigation() {
        self.app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let profileSettingsButton = self.app.buttons["pencil.and.scribble"]
        XCTAssertTrue(profileSettingsButton.exists, "Profile settings button does not exist.")
        profileSettingsButton.tap()

        let profileSettingsViewTitle = self.app.navigationBars["Profile Settings"]
        XCTAssertTrue(profileSettingsViewTitle.exists, "Failed to navigate to Profile Settings view.")
    }

    func testLogOutAction() {
        self.app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let logOutButton = self.app.buttons["Log Out"]
        XCTAssertTrue(logOutButton.exists, "Log Out button does not exist.")
        logOutButton.tap()

        let splashViewTitle = self.app.staticTexts["Welcome Quiz App!"]
        XCTAssertTrue(splashViewTitle.exists, "Failed to navigate to SplashView after logging out.")
    }

    func testDeleteAccountConfirmation() {
        self.app.buttons["Login"].tap()

        let emailTextField = self.app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("sevva@gmail.com")

        let passwordSecureField = self.app.secureTextFields["Password"]
        passwordSecureField.tap()
        passwordSecureField.typeText("123456")

        self.app.buttons["Sign In"].tap()

        let profilButton = self.app.tabBars["Tab Bar"].buttons["Profile"]
        XCTAssertTrue(profilButton.waitForExistence(timeout: 5))
        profilButton.tap()

        let deleteAccountButton = self.app.buttons["Delete Account"]
        XCTAssertTrue(deleteAccountButton.exists, "Delete Account button does not exist.")
        deleteAccountButton.tap()

        // Assert the confirmation dialog is shown
        let alert = self.app.alerts["Confirm Delete"]
        XCTAssertTrue(alert.exists, "Delete confirmation alert did not appear.")

        let confirmButton = alert.buttons["Yes"]
        XCTAssertTrue(confirmButton.exists, "Confirm button on delete account alert does not exist.")
        confirmButton.tap()

        let splashViewTitle = self.app.staticTexts["Welcome Quiz App!"]
        XCTAssertTrue(splashViewTitle.waitForExistence(timeout: 5), "Failed to navigate to SplashView after account deletion.")
    }
}
