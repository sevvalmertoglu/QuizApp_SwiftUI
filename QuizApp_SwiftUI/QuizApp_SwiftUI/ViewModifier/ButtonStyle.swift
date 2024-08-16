//
//  ButtonStyle.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 16.08.2024.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 15))
            .frame(maxWidth: .infinity)
            .background(Color.indigo)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonStyle())
    }
}
