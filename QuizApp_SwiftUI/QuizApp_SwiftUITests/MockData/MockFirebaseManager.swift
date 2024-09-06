//
//  MockFirebaseManager.swift
//  QuizApp_SwiftUITests
//
//  Created by Şevval Mertoğlu on 4.09.2024.
//

@testable import QuizApp_SwiftUI
import Foundation
import SwiftUI

class MockFirebaseManager: FirebaseManager {
    var resultToReturn: Result<User, Error>?
    var registerResult: Result<User, Error>?
    var fetchUserDataResult: Result<User, Error>?
    var saveScoreResult: Result<Void, Error>?
    var updateUserProfileResult: Result<Void, Error>?
    var saveUserIconResult: Result<Void, Error>?
    var fetchLeaderboardResult: Result<[(nickname: String, totalScore: Int, userId: String)], Error>?
    var deleteUserDataResult: Result<Void, Error>?
    var fetchScoresResult: Result<[Score], Error>?
    var fetchUserIconResult: Result<String, Error>?
    var updateLeaderboardResult: Result<Void, Error>?

    override func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        if let result = resultToReturn {
            completion(result)
        } else {
            completion(.failure(NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock sign in error."])))
        }
    }

    override func register(email: String, password: String, name: String, nickname: String, completion: @escaping (Result<User, Error>) -> Void) {
        if let result = resultToReturn {
            completion(result)
        } else {
            completion(.failure(NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock registration error."])))
        }
    }

    override func fetchUserData(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        if let result = fetchUserDataResult {
            completion(result)
        }
    }

    override func saveScore(correctCount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = saveScoreResult {
            completion(result)
        }
    }

    override func updateUserProfile(userId: String, name: String, nickname: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = updateUserProfileResult {
            completion(result)
        }
    }

    override func saveUserIcon(userId: String, iconName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = saveUserIconResult {
            completion(result)
        }
    }

    override func fetchLeaderboard(completion: @escaping (Result<[(nickname: String, totalScore: Int, userId: String)], Error>) -> Void) {
        if let result = fetchLeaderboardResult {
            completion(result)
        }
    }

    override func updateLeaderboard(userId: String, nickname: String, totalScore: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = updateLeaderboardResult {
            completion(result)
        } else {
            completion(.success(()))
        }
    }

    override func deleteUserData(userId: String, completion: @escaping (Error?) -> Void) {
        if let result = deleteUserDataResult {
            switch result {
            case .success:
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        } else {
            completion(nil)
        }
    }

    override func fetchScores(forUserId userId: String, completion: @escaping (Result<[Score], Error>) -> Void) {
        if let result = fetchScoresResult {
            completion(result)
        }
    }

    override func fetchUserIcon(userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        if let result = fetchUserIconResult {
            completion(result)
        } else {
            completion(.success("user"))
        }
    }
}
