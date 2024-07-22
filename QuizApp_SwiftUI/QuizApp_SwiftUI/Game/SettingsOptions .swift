//
//  SettingsOptions .swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation

protocol SettingsModelDelegate {
}

struct SettingsModel {
}

struct SettingsOptions {
    var numberOfQuestions: Int = 10
    var difficulty: String?
    var category: Int = 0
    var type: String?
}

struct UIData {
    var question: String
    var answers: [Answers]
    var percentage: Float
    var type: String
}

struct Answers {
    var text: String
    var correct: Bool
}
