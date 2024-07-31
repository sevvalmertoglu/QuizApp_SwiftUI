//
//  Answer.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import Foundation

public class Answer: Identifiable {
    public var uuid: UUID
    public var text: String
    public var incorrect: Bool

    public init() {
        self.uuid = UUID()
        self.text = "Text"
        self.incorrect = true
    }

    public init(_ text: String, incorrect: Bool) {
        self.uuid = UUID()
        self.text = text
        self.incorrect = incorrect
    }
}
