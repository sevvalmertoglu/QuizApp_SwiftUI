//
//  QuestionsView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import CoreAPI
import SwiftUI

// MARK: - - QuestionsView

// View that controls which question to be displayed and redirects to result screen
struct QuestionsView: View {
    @StateObject private var viewModel = QuestionsViewModel()
    
    // Parameters
    @Binding var questions: [Question]
    
    // Properties
    @State var currentQuestionIndex: Int = 0
    @State var possibilities: [Answer] = []
    @State var clicked: Bool = false // State variable that determines if an option was clicked
    @State var selectionCorrect: Bool = false
    @State var displayResults: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        if displayResults == false {
                            Text("\(questions[currentQuestionIndex].category)")
                        }
                        Spacer()
                        Text("\(currentQuestionIndex + 1) / \(questions.count)")
                    }
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    
                    if displayResults == false {
                        triviaQuizView()
                    } else {
                        resultsView()
                    } // else
                    
                    Spacer()
                } // VStack
                .onAppear {
                    possibilities = viewModel.initPossiblities(question: questions[currentQuestionIndex])
                }
            } // ZStack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            ProgressBar(percentComplete: Double(currentQuestionIndex + 1) / Double(questions.count))
        } // VStack
    }
    
    func nextClicked() {
        if selectionCorrect == true {
            viewModel.correctCount += 1
        } else {
            viewModel.incorrectCount += 1
        }
        if currentQuestionIndex + 1 >= questions.count {
            displayResults = true
            return
        }
        currentQuestionIndex += 1
        clicked = false
        selectionCorrect = false
    }
    
    @ViewBuilder
    func triviaQuizView() -> some View {
        QuestionView(question: questions[currentQuestionIndex].question, possibilities: possibilities, clicked: $clicked, selectionCorrect: $selectionCorrect)
            .onChange(of: currentQuestionIndex) { _, _ in
                possibilities = viewModel.initPossiblities(question: questions[currentQuestionIndex])
            }
        if clicked {
            Button(action: {
                nextClicked()
            }) {
                Text("Next")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color.backgroundColor)
                    .frame(width: 150, height: 60)
                    .background(Color.indigo)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding([.top], 30)
            } // Button
        }
    }
    
    @ViewBuilder
    func resultsView() -> some View {
        ZStack {
            Image("backgroundGameOver")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
                .offset(x: -4)
            
            Text("GAME OVER!")
                .font(.system(size: 50, weight: .heavy))
                .foregroundColor(.indigo)
                .padding(.bottom, 260)
            
            VStack(spacing: 30) {
                VStack() {
                    if Double(viewModel.correctCount) / Double(questions.count) >= 0.8 {
                        Text("Great work 🎉\n\nYou got \(viewModel.correctCount) out of \(questions.count) questions right!")
                    } else if Double(viewModel.correctCount) / Double(questions.count) >= 0.5 {
                        Text("Good job!\n\nYou got \(viewModel.correctCount) out of \(questions.count) questions right!")
                    } else {
                        Text("You got \(viewModel.correctCount) out of \(questions.count) questions right.\n\nPractice makes perfect!")
                    }
                } // Message VStack
                
                Button(action: {
                    self.dismiss()
                }) {
                    Text("Play Again")
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.backgroundColor)
                        .background(Color.indigo)
                        .cornerRadius(12)
                } // Button
            } // VStack
            .font(.system(size: 28, weight: .medium))
            .padding([.top], 100)
        }
    }
}

#Preview {
    QuestionsView(questions: .constant([Question(), Question(), Question()]))
        .preferredColorScheme(.light)
}
