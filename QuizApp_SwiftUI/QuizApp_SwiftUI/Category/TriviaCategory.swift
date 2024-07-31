//
//  TriviaCategory.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import Foundation

public class TriviaCategory: Decodable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public class TriviaCategories: Decodable {
    public let trivia_categories: [TriviaCategory]

    public init(trivia_categories: [TriviaCategory]) {
        self.trivia_categories = trivia_categories
    }
}
