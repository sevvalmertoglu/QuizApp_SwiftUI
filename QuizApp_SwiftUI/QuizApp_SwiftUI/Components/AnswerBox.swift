//
//  AnswerBox.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import CoreAPI
import SwiftUI

// MARK: AnswerBox

// A box of the answer
struct AnswerBox: View {
    // Parameters
    let possibility: Answer
    @Binding var selectedUUID: UUID // Relays to QuestionView of selection is incorrect / correct
    @Binding var clickedComplete: Bool
    @Binding var selectionCorrect: Bool

    // Private properties
    @State private var wasSelected: Bool = false // Highlights only the selected box

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Button(action: {
                    if possibility.incorrect == false {
                        selectionCorrect = true
                    }
                    withAnimation(.easeOut(duration: 0.1)) {
                        clickedComplete = true
                        wasSelected = true
                    }
                }) {
                    HStack(spacing: 0) {
                        Text(possibility.text)
                            .font(.system(size: 24, weight: .medium))
                            .minimumScaleFactor(0.3)
                            .lineLimit(nil)
                            .foregroundColor(Color.black)
                            .padding(4)
                            .padding([.leading], wasSelected ? 40 : 0)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                        if wasSelected == true {
                            Image(systemName: clickedComplete == true && possibility.incorrect == false ? "checkmark" : "xmark")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: 60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                    }
                } // button
                .background(markCorrect())
                .cornerRadius(12)
                .frame(width: geometry.size.width) // Centers the ZStack
            }
            .frame(height: 60)
        }
    }

    func markCorrect() -> Color {
        if clickedComplete == true && possibility.incorrect == false { // Correct; display correct unconditionally
            return Color.green // Returns green color unconditionally after clicked complete was finished
        }

        if wasSelected == true && possibility.incorrect == true { // Mark the incorrect button that was selected
            return Color.red // Return red if selected was incorrect
        }

        return Color.white // Returns white by default (non-selected)
    }
}
