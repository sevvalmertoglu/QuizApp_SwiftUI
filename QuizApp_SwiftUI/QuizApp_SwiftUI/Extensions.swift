//
//  Extension.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//
import SwiftUI

public extension Color {
    static let backgroundColor = Color("BackgroundColor")
    static let contrastColor = Color("ContrastColor")

    // Custom initializer than accepts a hexadecimal
    internal init(hex: Int, opacity: Double = 1.0) {
        // Note: 0xff = 255
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension String {
    func base64Decode() -> String? {
        if let data = Data(base64Encoded: self, options: [.ignoreUnknownCharacters]) {
            return String(data: data, encoding: .utf16)
        }
        return nil
    }
}