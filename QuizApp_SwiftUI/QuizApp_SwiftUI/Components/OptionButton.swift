//
//  OptionButton.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import SwiftUI

struct OptionButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    let isSelected: Bool

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: self.action) {
            Text(self.title)
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(self.isSelected == true
                    ? Color.backgroundColor
                    : Color.indigo)
                .padding([.leading, .trailing], 4)
                .minimumScaleFactor(0.8) // Allows text to reduce in size, reduces to 24 * 0.5
                .frame(maxWidth: 150)
                .frame(height: 60)
                .background(self.isSelected == true
                    ? Color.indigo
                    : Color.backgroundColor)
                .cornerRadius(20)
        }
        .accessibilityValue(self.isSelected ? "Selected" : "Not Selected")
    }
}

struct OptionButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionButton(title: "Multiple Choice", action: {}, isSelected: true)
            .preferredColorScheme(.dark)
    }
}
