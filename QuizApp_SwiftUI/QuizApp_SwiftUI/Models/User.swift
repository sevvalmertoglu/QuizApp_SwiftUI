//
//  User.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation

struct User {
    var name: String
    var nickname: String
    var email: String
    var Scores: [Score]
}

struct Score: Codable {
    let date: String
    let score: Int
}
