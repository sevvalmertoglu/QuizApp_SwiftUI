//
//  FirebaseManager.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import FirebaseAuth
import FirebaseDatabase
import Foundation

class FirebaseManager {
    static let shared = FirebaseManager()
    private let dbRef = Database.database().reference()

    private init() {}

    // MARK: - Authentication Methods

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                self.fetchUserData(userId: user.uid, completion: completion)
            }
        }
    }

    func register(email: String, password: String, name: String, nickname: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                let userData = [
                    "name": name,
                    "nickname": nickname,
                    "email": email,
                    "userIcon": "user" // Set the default profile icon
                ]
                self.dbRef.child("users").child(user.uid).setValue(userData) { error, _ in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        let newUser = User(name: name, nickname: nickname, email: email, Scores: [])
                        completion(.success(newUser))
                    }
                }
            }
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func fetchUserData(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        self.dbRef.child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any],
                  let name = value["name"] as? String,
                  let nickname = value["nickname"] as? String,
                  let email = value["email"] as? String
            else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data is malformed."])))
                return
            }
            var scores: [Score] = []
            if let scoresData = value["scores"] as? [String: [String: Any]] {
                scores = scoresData.compactMap { _, value in
                    if let date = value["date"] as? String, let score = value["score"] as? Int {
                        return Score(date: date, score: score)
                    }
                    return nil
                }
            }
            let user = User(name: name, nickname: nickname, email: email, Scores: scores)
            completion(.success(user))
        }
    }

    // MARK: - User Delete Methods

    func deleteUserData(userId: String, completion: @escaping (Error?) -> Void) {
        let userRef = self.dbRef.child("users").child(userId)
        userRef.removeValue { error, _ in
            completion(error)
        }
    }

    // MARK: - Score Methods

    func saveScore(correctCount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in."])))
            return
        }

        let score = correctCount * 100
        let scoreData = Score(date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short), score: score)

        self.fetchUserData(userId: userId) { result in
            switch result {
            case var .success(userData):
                self.updateUserScores(with: scoreData, in: &userData)
                let totalScore = self.calculateTotalScore(from: userData)
                userData["totalScore"] = totalScore

                self.saveUserData(userId: userId, userData: userData) { result in
                    switch result {
                    case .success:
                        self.updateLeaderboard(userId: userId, nickname: userData["nickname"] as? String ?? "", totalScore: totalScore, completion: completion)
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // Helper Functions

    private func fetchUserData(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        self.dbRef.child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
            if let userData = snapshot.value as? [String: Any] {
                completion(.success(userData))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user data."])))
            }
        }
    }

    private func updateUserScores(with scoreData: Score, in userData: inout [String: Any]) {
        var scores = userData["scores"] as? [[String: Any]] ?? []
        let newScore = [
            "date": scoreData.date,
            "score": scoreData.score
        ] as [String: Any]
        scores.append(newScore)
        userData["scores"] = scores
    }

    private func calculateTotalScore(from userData: [String: Any]) -> Int {
        let scores = userData["scores"] as? [[String: Any]] ?? []
        return scores.reduce(0) { $0 + ($1["score"] as? Int ?? 0) }
    }

    private func saveUserData(userId: String, userData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        self.dbRef.child("users").child(userId).setValue(userData) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func fetchScores(forUserId userId: String, completion: @escaping (Result<[Score], Error>) -> Void) {
        self.dbRef.child("users").child(userId).child("scores").observeSingleEvent(of: .value) { snapshot in
            var fetchedScores: [Score] = []

            if let scoresData = snapshot.value as? [[String: Any]] {
                fetchedScores = scoresData.compactMap { dict in
                    guard let date = dict["date"] as? String,
                          let score = dict["score"] as? Int
                    else {
                        return nil
                    }
                    return Score(date: date, score: score)
                }
                completion(.success(fetchedScores))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No scores found."])))
            }
        } withCancel: { error in
            completion(.failure(error))
        }
    }

    // MARK: - User Icon Methods

    func saveUserIcon(userId: String, iconName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        self.dbRef.child("users").child(userId).child("userIcon").setValue(iconName) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func fetchUserIcon(userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        self.dbRef.child("users").child(userId).child("userIcon").observe(.value) { snapshot in
            if let iconName = snapshot.value as? String {
                completion(.success(iconName))
            } else {
                completion(.success("user")) // Default to "user" icon if not found
            }
        } withCancel: { error in
            completion(.failure(error))
        }
    }

    // MARK: - LeaderBoard Methods

    func updateLeaderboard(userId: String, nickname: String, totalScore: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let leaderboardRef = self.dbRef.child("leaderboard").child(userId)
        let values = [
            "nickname": nickname,
            "totalScore": totalScore
        ] as [String: Any]

        leaderboardRef.updateChildValues(values) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func fetchLeaderboard(completion: @escaping (Result<[(nickname: String, totalScore: Int, userId: String)], Error>) -> Void) {
        self.dbRef.child("leaderboard").queryOrdered(byChild: "totalScore").observe(.value) { snapshot in
            var leaderboard: [(nickname: String, totalScore: Int, userId: String)] = []
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? [String: Any]
                let nickname = value?["nickname"] as? String ?? ""
                let totalScore = value?["totalScore"] as? Int ?? 0
                let userId = child.key
                leaderboard.append((nickname: nickname, totalScore: totalScore, userId: userId))
            }
            completion(.success(leaderboard))
        } withCancel: { error in
            completion(.failure(error))
        }
    }
}
