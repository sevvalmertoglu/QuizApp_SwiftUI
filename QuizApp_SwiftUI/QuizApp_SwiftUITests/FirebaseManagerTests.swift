//
//  FirebaseManagerTests.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 4.09.2024.
//

@testable import QuizApp_SwiftUI
import FirebaseAuth
import FirebaseDatabase
import XCTest

class FirebaseManagerTests: XCTestCase {
    var firebaseManager: MockFirebaseManager!

    override func setUp() {
        super.setUp()
        self.firebaseManager = MockFirebaseManager()
    }

    override func tearDown() {
        self.firebaseManager = nil
        super.tearDown()
    }

    func testSignInSuccess() {
        let user = User(name: "Test User", nickname: "test", email: "test@example.com", Scores: [])
        self.firebaseManager.resultToReturn = .success(user)

        let expectation = self.expectation(description: "Sign in success")
        self.firebaseManager.signIn(email: "test@example.com", password: "password") { result in
            switch result {
            case let .success(user):
                XCTAssertEqual(user.email, "test@example.com")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSignInFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sign in failed"])
        self.firebaseManager.resultToReturn = .failure(error)

        let expectation = self.expectation(description: "Sign in failure")
        self.firebaseManager.signIn(email: "test@example.com", password: "password") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Sign in failed")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testRegisterSuccess() {
        let user = User(name: "Test User", nickname: "test", email: "test@example.com", Scores: [])
        self.firebaseManager.resultToReturn = .success(user)

        let expectation = self.expectation(description: "Register success")
        self.firebaseManager.register(email: "test@example.com", password: "password", name: "Test User", nickname: "test") { result in
            switch result {
            case let .success(user):
                XCTAssertEqual(user.email, "test@example.com")
                XCTAssertEqual(user.name, "Test User")
                XCTAssertEqual(user.nickname, "test")
            case let .failure(error):
                XCTFail("Expected success but got failure: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testRegisterFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock register error."])
        self.firebaseManager.resultToReturn = .failure(error)

        let expectation = self.expectation(description: "Register failure")
        self.firebaseManager.register(email: "test@example.com", password: "password", name: "Test User", nickname: "test") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Mock register error.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUserDataSuccess() {
        let user = User(name: "Test User", nickname: "test", email: "test@example.com", Scores: [])
        self.firebaseManager.fetchUserDataResult = .success(user)

        let expectation = self.expectation(description: "Fetch user data success")
        self.firebaseManager.fetchUserData(userId: "testUserId") { result in
            switch result {
            case let .success(user):
                XCTAssertEqual(user.email, "test@example.com")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUserDataFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Fetch user data failed"])
        self.firebaseManager.fetchUserDataResult = .failure(error)

        let expectation = self.expectation(description: "Fetch user data failure")
        self.firebaseManager.fetchUserData(userId: "testUserId") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Fetch user data failed")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSaveScoreSuccess() {
        self.firebaseManager.saveScoreResult = .success(())

        let expectation = self.expectation(description: "Save score success")
        self.firebaseManager.saveScore(correctCount: 10) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSaveScoreFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Save score failed"])
        self.firebaseManager.saveScoreResult = .failure(error)

        let expectation = self.expectation(description: "Save score failure")
        self.firebaseManager.saveScore(correctCount: 10) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Save score failed")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUpdateUserProfileSuccess() {
        self.firebaseManager.updateUserProfileResult = .success(())

        let expectation = self.expectation(description: "Update user profile success")
        self.firebaseManager.updateUserProfile(userId: "testUserId", name: "New Name", nickname: "newNickname") { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUpdateUserProfileFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Update user profile failed"])
        self.firebaseManager.updateUserProfileResult = .failure(error)

        let expectation = self.expectation(description: "Update user profile failure")
        self.firebaseManager.updateUserProfile(userId: "testUserId", name: "New Name", nickname: "newNickname") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Update user profile failed")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSaveUserIconSuccess() {
        self.firebaseManager.saveUserIconResult = .success(())

        let expectation = self.expectation(description: "Save user icon success")
        self.firebaseManager.saveUserIcon(userId: "testUserId", iconName: "newIcon") { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSaveUserIconFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Save user icon failed"])
        self.firebaseManager.saveUserIconResult = .failure(error)

        let expectation = self.expectation(description: "Save user icon failure")
        self.firebaseManager.saveUserIcon(userId: "testUserId", iconName: "newIcon") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Save user icon failed")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDeleteUserDataSuccess() {
        let expectation = self.expectation(description: "Delete user data success")
        self.firebaseManager.deleteUserData(userId: "testUserId") { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDeleteUserDataFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Delete user data failed"])
        self.firebaseManager.deleteUserDataResult = .failure(error)

        let expectation = self.expectation(description: "Delete user data failure")
        self.firebaseManager.deleteUserData(userId: "testUserId") { returnedError in
            XCTAssertEqual(returnedError?.localizedDescription, "Delete user data failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchScoresSuccess() {
        let scores = [
            Score(date: "2024-09-01", score: 100),
            Score(date: "2024-09-02", score: 200)
        ]

        self.firebaseManager.fetchScoresResult = .success(scores)
        let expectation = self.expectation(description: "Fetch scores success")
        self.firebaseManager.fetchScores(forUserId: "testUserId") { result in
            switch result {
            case let .success(fetchedScores):
                XCTAssertEqual(fetchedScores.count, scores.count)
                XCTAssertEqual(fetchedScores.first?.date, "2024-09-01")
                XCTAssertEqual(fetchedScores.first?.score, 100)
                XCTAssertEqual(fetchedScores.last?.date, "2024-09-02")
                XCTAssertEqual(fetchedScores.last?.score, 200)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchScoresFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch scores"])
        self.firebaseManager.fetchScoresResult = .failure(error)
        let expectation = self.expectation(description: "Fetch scores failure")
        self.firebaseManager.fetchScores(forUserId: "testUserId") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Failed to fetch scores")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchLeaderboardSuccess() {
        let leaderboard = [
            (nickname: "Player1", totalScore: 1000, userId: "user1"),
            (nickname: "Player2", totalScore: 800, userId: "user2")
        ]

        self.firebaseManager.fetchLeaderboardResult = .success(leaderboard)
        let expectation = self.expectation(description: "Fetch leaderboard success")

        self.firebaseManager.fetchLeaderboard { result in
            switch result {
            case let .success(fetchedLeaderboard):
                XCTAssertEqual(fetchedLeaderboard.count, leaderboard.count)
                XCTAssertEqual(fetchedLeaderboard.first?.nickname, "Player1")
                XCTAssertEqual(fetchedLeaderboard.first?.totalScore, 1000)
                XCTAssertEqual(fetchedLeaderboard.last?.nickname, "Player2")
                XCTAssertEqual(fetchedLeaderboard.last?.totalScore, 800)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchLeaderboardFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch leaderboard"])

        self.firebaseManager.fetchLeaderboardResult = .failure(error)
        let expectation = self.expectation(description: "Fetch leaderboard failure")

        self.firebaseManager.fetchLeaderboard { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err):
                XCTAssertEqual(err.localizedDescription, "Failed to fetch leaderboard")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUpdateLeaderboardSuccess() {
        self.firebaseManager.updateLeaderboardResult = .success(())

        let expectation = self.expectation(description: "Update leaderboard success")

        self.firebaseManager.updateLeaderboard(userId: "testUserId", nickname: "TestUser", totalScore: 1000) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUpdateLeaderboardFailure() {
        let error = NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Update leaderboard failed"])
        self.firebaseManager.updateLeaderboardResult = .failure(error)

        let expectation = self.expectation(description: "Update leaderboard failure")

        self.firebaseManager.updateLeaderboard(userId: "testUserId", nickname: "TestUser", totalScore: 1000) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(err as NSError):
                XCTAssertEqual(err.localizedDescription, "Update leaderboard failed")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUserIconSuccess() {
        let expectedIconName = "testIcon"
        self.firebaseManager.fetchUserIconResult = .success(expectedIconName)

        let expectation = self.expectation(description: "Fetch user icon success")

        self.firebaseManager.fetchUserIcon(userId: "testUserId") { result in
            switch result {
            case let .success(iconName):
                XCTAssertEqual(iconName, expectedIconName)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUserIconDefaultIcon() {
        // Should return default "user" icon when simulated user icon is not found
        self.firebaseManager.fetchUserIconResult = .success("user")

        let expectation = self.expectation(description: "Fetch user icon default icon")

        self.firebaseManager.fetchUserIcon(userId: "testUserId") { result in
            switch result {
            case let .success(iconName):
                XCTAssertEqual(iconName, "user")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUserIconFailure() {
        let error = NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Fetch icon failed"])
        self.firebaseManager.fetchUserIconResult = .failure(error)

        let expectation = self.expectation(description: "Fetch user icon failure")

        self.firebaseManager.fetchUserIcon(userId: "testUserId") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case let .failure(fetchError as NSError):
                XCTAssertEqual(fetchError.localizedDescription, "Fetch icon failed")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
