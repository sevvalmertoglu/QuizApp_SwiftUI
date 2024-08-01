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
                    "email": email
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

    func saveScore(correctCount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in."])))
            return
        }

        let score = correctCount * 100
        let scoreData = Score(date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short), score: score)

        self.dbRef.child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
            if var userData = snapshot.value as? [String: Any] {
                var scores = userData["scores"] as? [[String: Any]] ?? []
                let newScore = [
                    "date": scoreData.date,
                    "score": scoreData.score
                ] as [String: Any]
                scores.append(newScore)
                userData["scores"] = scores

                self.dbRef.child("users").child(userId).setValue(userData) { error, _ in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user data."])))
            }
        }
    }

    func deleteUserData(userId: String, completion: @escaping (Error?) -> Void) {
        let userRef = self.dbRef.child("users").child(userId)
        userRef.removeValue { error, _ in
            completion(error)
        }
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
}
