//
//  QuestionsView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import SwiftUI
import CoreAPI

// MARK: -- QuestionView

// Displays a singular question and relays back to QuestionsView once selected
struct QuestionView: View {
    // Required params:
    let question: String
    let possibilities: Array<Answer>
    @Binding var clicked: Bool
    @Binding var selectionCorrect: Bool
    
    // Properties
    @State private var selectedUUID = UUID()
    
    var body: some View {
        ZStack {
            VStack {
                Text(question)
                    .font(.system(size: 24, weight: .medium))
                    .padding()
                
                // ForEach
                VStack(spacing: 30) {
                    ForEach(possibilities, id: \.uuid) { possibility in
                        AnswerBox(possibility: possibility, selectedUUID: $selectedUUID, clickedComplete: $clicked, selectionCorrect: $selectionCorrect)
                            .disabled(clicked)
                    }
                }
            } // VStack
        } // ZStack
    }
}


