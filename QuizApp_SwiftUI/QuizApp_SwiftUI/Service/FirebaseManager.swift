//
//  FirebaseManager.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    private let dbRef = Database.database().reference()
    
    private init() { }
    
    func signIn(email: String, password: String) -> Future<User, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = authResult?.user {
                    self.fetchUserData(userId: user.uid, completion: promise)
                }
            }
        }
    }
    
    func register(email: String, password: String, name: String, nickname: String) -> Future<User, Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let user = authResult?.user {
                    let userData = ["name": name, "nickname": nickname, "email": email, "profileIcon": "user"]
                    self.dbRef.child("users").child(user.uid).setValue(userData) { error, _ in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            let newUser = User(name: name, nickname: nickname, email: email, Scores: [])
                            promise(.success(newUser))
                        }
                    }
                }
            }
        }
    }
    
    func fetchUserData(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        dbRef.child("users").child(userId).observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any],
                  let name = value["name"] as? String,
                  let nickname = value["nickname"] as? String,
                  let email = value["email"] as? String else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data is malformed."])))
                return
            }
            var scores: [Score] = []
            if let scoresData = value["scores"] as? [String: [String: Any]] {
                scores = scoresData.compactMap { key, value in
                    if let date = value["date"] as? String, let score = value["score"] as? Int {
                        return Score(date: date, score: score)
                    }
                    return nil
                }
            }
            let user = User(name: name, nickname: nickname, email: email, Scores: scores)
            completion(.success(user))
        }) { error in
            completion(.failure(error))
        }
    }

    
    func fetchLeaderboard() -> Future<[(nickname: String, totalScore: Int, userId: String)], Error> {
        return Future { promise in
            self.dbRef.child("leaderboard").queryOrdered(byChild: "totalScore").observeSingleEvent(of: .value) { snapshot in
                var leaderboard: [(nickname: String, totalScore: Int, userId: String)] = []
                for child in snapshot.children.reversed() {
                    if let snapshot = child as? DataSnapshot,
                       let value = snapshot.value as? [String: Any],
                       let nickname = value["nickname"] as? String,
                       let totalScore = value["totalScore"] as? Int {
                        let userId = snapshot.key
                        leaderboard.append((nickname: nickname, totalScore: totalScore, userId: userId))
                    }
                }
                promise(.success(leaderboard))
            } withCancel: { error in
                promise(.failure(error))
            }
        }
    }
}
