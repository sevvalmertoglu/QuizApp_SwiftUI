//
//  ProfileViewUITest.swift
//  QuizApp_SwiftUIUITests
//
//  Created by Şevval Mertoğlu on 13.09.2024.
//

@testable import QuizApp_SwiftUI // Your app's module name
import SwiftUI
import XCTest

class ProfileViewUITests: XCTestCase {
    func testProfileViewUIElements() {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let profileTitle = app.staticTexts["Profile"]
        let nameLabel = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Name:'")).element
        let nicknameLabel = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Nickname:'")).element
        let emailLabel = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Mail:'")).element
        let totalScoreLabel = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Total Score:'")).element
        let pencilButton = app.buttons["pencil.and.scribble"]
        let previousScoresButton = app.buttons["Previous Scores"]
        let logOutButton = app.buttons["Log Out"]
        let resetPasswordButton = app.buttons["Reset Password"]
        let deleteAccountButton = app.buttons["Delete Account"]

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
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let previousScoresButton = app.buttons["Previous Scores"]
        XCTAssertTrue(previousScoresButton.exists, "Previous Scores button does not exist.")
        previousScoresButton.tap()

        let previousScoresViewTitle = app.navigationBars["Previous Scores"]
        XCTAssertTrue(previousScoresViewTitle.exists, "Failed to navigate to Previous Scores view.")
    }

    func testProfileSettingsNavigation() {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let profileSettingsButton = app.buttons["pencil.and.scribble"]
        XCTAssertTrue(profileSettingsButton.exists, "Profile settings button does not exist.")
        profileSettingsButton.tap()

        let profileSettingsViewTitle = app.navigationBars["Profile Settings"]
        XCTAssertTrue(profileSettingsViewTitle.exists, "Failed to navigate to Profile Settings view.")
    }

    func testLogOutAction() {
        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Profile"].tap()

        let logOutButton = app.buttons["Log Out"]
        XCTAssertTrue(logOutButton.exists, "Log Out button does not exist.")
        logOutButton.tap()

        let splashViewTitle = app.staticTexts["Welcome Quiz App!"]
        XCTAssertTrue(splashViewTitle.exists, "Failed to navigate to SplashView after logging out.")
    }

    func testDeleteAccountConfirmation() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["Login"].tap()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("sevva@gmail.com")

        let passwordSecureField = app.secureTextFields["Password"]
        passwordSecureField.tap()
        passwordSecureField.typeText("123456")

        app.buttons["Sign In"].tap()

        let profilButton = app.tabBars["Tab Bar"].buttons["Profile"]
        XCTAssertTrue(profilButton.waitForExistence(timeout: 5))
        profilButton.tap()

        let deleteAccountButton = app.buttons["Delete Account"]
        XCTAssertTrue(deleteAccountButton.exists, "Delete Account button does not exist.")
        deleteAccountButton.tap()

        // Assert the confirmation dialog is shown
        let alert = app.alerts["Confirm Delete"]
        XCTAssertTrue(alert.exists, "Delete confirmation alert did not appear.")

        let confirmButton = alert.buttons["Yes"]
        XCTAssertTrue(confirmButton.exists, "Confirm button on delete account alert does not exist.")
        confirmButton.tap()

        let splashViewTitle = app.staticTexts["Welcome Quiz App!"]
        XCTAssertTrue(splashViewTitle.waitForExistence(timeout: 5), "Failed to navigate to SplashView after account deletion.")
    }
}
