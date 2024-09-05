//
//  TriviaCategory.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import Foundation

public class TriviaCategory: Equatable, Decodable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    public static func ==(lhs: TriviaCategory, rhs: TriviaCategory) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

public class TriviaCategories: Decodable {
    public let trivia_categories: [TriviaCategory]

    public init(trivia_categories: [TriviaCategory]) {
        self.trivia_categories = trivia_categories
    }
}
