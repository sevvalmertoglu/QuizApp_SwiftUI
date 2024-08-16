//
//  RoundedRectangleModifier.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 16.08.2024.
//

import Foundation
import SwiftUI

struct RoundedRectangleModifier: ViewModifier {
    var shadowColor: Color
    var text: LocalizedStringKey
    var fontSize: CGFloat

    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: 120)
            .frame(width: 350, height: 35, alignment: .center)
            .foregroundColor(.white)
            .shadow(color: self.shadowColor, radius: 8, y: 5)
            .overlay(
                Text(self.text)
                    .foregroundColor(.indigo)
                    .font(.system(size: self.fontSize))
            )
    }
}

extension View {
    func roundedRectangleStyle(shadowColor: Color, text: LocalizedStringKey, fontSize: CGFloat) -> some View {
        modifier(RoundedRectangleModifier(shadowColor: shadowColor, text: text, fontSize: fontSize))
    }
}
