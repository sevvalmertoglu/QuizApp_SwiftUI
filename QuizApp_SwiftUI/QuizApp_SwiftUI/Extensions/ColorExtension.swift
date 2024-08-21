//
//  Extension.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//
import SwiftUI

extension Color {
    public static let backgroundColor = Color("BackgroundColor")
    public static let contrastColor = Color("ContrastColor")

    // Custom initializer than accepts a hexadecimal
    init(hex: Int, opacity: Double = 1.0) {
        // Note: 0xff = 255
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension Color {
    static let backgroundPurple = Color(red: 0.49, green: 0.45, blue: 0.89)
    static let textColor = Color(red: 0.38, green: 0.36, blue: 0.73)
    static let greenishGray = Color(red: 0.52, green: 0.48, blue: 0.91)
    static let oliveGreen = Color(red: 0.46, green: 0.44, blue: 0.79)
    static let shadowColor = Color(red: 0.25, green: 0.22, blue: 0.50).opacity(0.35)
}
