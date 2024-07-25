//
//  Category.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation

struct CategoryData: Decodable {
    var trivia_categories: [Category]
}

struct Category: Decodable, Identifiable {
    let id: Int
    let name: String
}

struct CategoryStats: Decodable {
    let category_id: Int
    var category_question_count: category_question_count
}

struct category_question_count: Decodable {
    let total_question_count: Int
    let total_easy_question_count: Int
    let total_medium_question_count: Int
    let total_hard_question_count: Int
}
