//
//  QuestionsView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import CoreAPI
import SwiftUI

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
    @State var timeRemaining: Int = 10 // Countdown timer
    @State var timer: Timer? = nil

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
                    startTimer()
                }
            } // ZStack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar) // To hide TabView

            ProgressBar(percentComplete: Double(currentQuestionIndex + 1) / Double(questions.count))
        } // VStack
    }

    func startTimer() {
        timeRemaining = 10
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.nextClicked()
            }
        }
    }

    func nextClicked() {
        if selectionCorrect {
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
        possibilities = viewModel.initPossiblities(question: questions[currentQuestionIndex])
        startTimer()
    }

    @ViewBuilder
    func triviaQuizView() -> some View {
        VStack {
            HStack {
                Image(systemName: "clock")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.indigo)
                Text("\(timeRemaining)")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.indigo)
            }
            .padding([.top], 10)

            QuestionView(question: questions[currentQuestionIndex].question, possibilities: possibilities, clicked: $clicked, selectionCorrect: $selectionCorrect, nextClicked: nextClicked)
                .onChange(of: currentQuestionIndex) { _, _ in
                    possibilities = viewModel.initPossiblities(question: questions[currentQuestionIndex])
                }
        }
    }

    @ViewBuilder
    func resultsView() -> some View {
        ZStack {
            Image("backgroundGameOver")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
                .offset(x: -10)

            Text("GAME OVER!")
                .font(.system(size: 50, weight: .heavy))
                .foregroundColor(.indigo)
                .padding(.bottom, 260)

            VStack(spacing: 30) {
                VStack {
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
