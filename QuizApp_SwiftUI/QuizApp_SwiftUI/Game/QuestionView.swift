//
//  QuestionView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import CoreAPI
import SwiftUI

// Displays a singular question and relays back to QuestionsView once selected
struct QuestionView: View {
    let question: String
    let possibilities: [Answer]
    @Binding var clicked: Bool
    @Binding var selectionCorrect: Bool
    var nextClicked: () -> Void

    @State private var selectedUUID = UUID()

    var body: some View {
        ZStack {
            VStack {
                Text(self.question)
                    .font(.system(size: 20, weight: .medium))
                    .padding()

                // ForEach
                VStack(spacing: 30) {
                    ForEach(self.possibilities, id: \.uuid) { possibility in
                        AnswerBox(possibility: possibility, selectedUUID: self.$selectedUUID, clickedComplete: self.$clicked, selectionCorrect: self.$selectionCorrect, nextClicked: self.nextClicked)
                            .disabled(self.clicked)
                    }
                }
            } // VStack
        } // ZStack
    }
}
