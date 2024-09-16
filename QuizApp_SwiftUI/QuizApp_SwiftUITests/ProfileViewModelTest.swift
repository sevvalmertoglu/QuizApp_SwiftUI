//
//  ProfileViewModelTest.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 16.09.2024.
//

import XCTest
@testable import QuizApp_SwiftUI

class ProfileViewModelTest: XCTestCase {
    
    var viewModel: ProfileViewModel!
    var mockFirebaseManager: MockFirebaseManager!
    
    override func setUpWithError() throws{
        super.setUp()
        mockFirebaseManager = MockFirebaseManager()
        FirebaseManager.shared = mockFirebaseManager
        let appState = AppState()
        viewModel = ProfileViewModel(appState: appState)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockFirebaseManager = nil
        super.tearDown()
    }
    
    func testFetchUserDataSuccess() {
        let user = User(name: "John Doe", nickname: "johndoe", email: "john@example.com", Scores: [Score(date: "2", score: 10), Score(date: "1", score: 20)])
        mockFirebaseManager.fetchUserDataResult = .success(user)
        mockFirebaseManager.fetchUserIconResult = .success("defaultIcon")
        
        viewModel.fetchUserData()
        
        let expectation = self.expectation(description: "Fetch user data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.name, "John Doe")
            XCTAssertEqual(self.viewModel.nickname, "johndoe")
            XCTAssertEqual(self.viewModel.email, "john@example.com")
            XCTAssertEqual(self.viewModel.totalScore, 30)
            XCTAssertEqual(self.viewModel.userIcon, UIImage(named: "defaultIcon"))
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertFalse(self.viewModel.showAlert)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchUserDataFailure() {
        mockFirebaseManager.fetchUserDataResult = .failure(NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        
        viewModel.fetchUserData()
        
        let expectation = self.expectation(description: "Fetch user data failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.alertMessage, "Mock error")
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResetPassword() {
        mockFirebaseManager.resetPasswordResult = .success(())
        
        viewModel.resetPassword()
        
        let expectation = self.expectation(description: "Reset password success")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.alertMessage, "Password reset email sent.")
            XCTAssertTrue(self.viewModel.showAlert)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLogOut() {
        do {
            try FirebaseManager.shared.signOut()
            viewModel.logOut()
            XCTAssertFalse(viewModel.appState.isUserLoggedIn)
            XCTAssertFalse(viewModel.showAlert)
        } catch {
            XCTFail("Logout failed with error: \(error.localizedDescription)")
        }
    }
    
    func testDeleteUserAccountSuccess() {
        mockFirebaseManager.deleteUserDataResult = .success(())
        
        viewModel.deleteUserAccount()
        
        let expectation = self.expectation(description: "Delete user account success")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertFalse(self.viewModel.showAlert)
            XCTAssertFalse(self.viewModel.appState.isUserLoggedIn)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDeleteUserAccountFailure() {
        mockFirebaseManager.deleteUserDataResult = .failure(NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock delete error"]))
        
        viewModel.deleteUserAccount()
        
        let expectation = self.expectation(description: "Delete user account failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.alertMessage, "Mock delete error")
            XCTAssertTrue(self.viewModel.showAlert)
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.appState.isUserLoggedIn)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
