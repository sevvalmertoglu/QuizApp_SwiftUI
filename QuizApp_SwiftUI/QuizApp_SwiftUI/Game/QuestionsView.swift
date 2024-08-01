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
                        if self.displayResults == false {
                            Text("\(self.questions[self.currentQuestionIndex].category)")
                        }
                        Spacer()
                        Text("\(self.currentQuestionIndex + 1) / \(self.questions.count)")
                    }
                    .font(.system(size: 20, weight: .bold))
                    .padding()

                    if self.displayResults == false {
                        self.triviaQuizView()
                    } else {
                        self.resultsView()
                    } // else

                    Spacer()
                } // VStack
                .onAppear {
                    self.possibilities = self.viewModel.initPossiblities(question: self.questions[self.currentQuestionIndex])
                    self.startTimer()
                }
            } // ZStack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar) // To hide TabView

            ProgressBar(percentComplete: Double(self.currentQuestionIndex + 1) / Double(self.questions.count))
        } // VStack
    }

    func startTimer() {
        self.timeRemaining = 10
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.nextClicked()
            }
        }
    }

    func nextClicked() {
        if self.selectionCorrect {
            self.viewModel.correctCount += 1
        } else {
            self.viewModel.incorrectCount += 1
        }
        if self.currentQuestionIndex + 1 >= self.questions.count {
            if !self.displayResults {
                self.displayResults = true
                self.viewModel.saveScoreToFirebase() // Save score to Firebase
            }
            return
        }
        self.currentQuestionIndex += 1
        self.clicked = false
        self.selectionCorrect = false
        self.possibilities = self.viewModel.initPossiblities(question: self.questions[self.currentQuestionIndex])
        self.startTimer()
    }

    @ViewBuilder
    func triviaQuizView() -> some View {
        VStack {
            HStack {
                Image(systemName: "clock")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.indigo)
                Text("\(self.timeRemaining)")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.indigo)
            }
            .padding([.top], 10)

            QuestionView(question: self.questions[self.currentQuestionIndex].question, possibilities: self.possibilities, clicked: self.$clicked, selectionCorrect: self.$selectionCorrect, nextClicked: self.nextClicked)
                .onChange(of: self.currentQuestionIndex) { _, _ in
                    self.possibilities = self.viewModel.initPossiblities(question: self.questions[self.currentQuestionIndex])
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
                    if Double(self.viewModel.correctCount) / Double(self.questions.count) >= 0.8 {
                        Text("Great work 🎉\n\nYou got \(self.viewModel.correctCount) out of \(self.questions.count) questions right!")
                    } else if Double(self.viewModel.correctCount) / Double(self.questions.count) >= 0.5 {
                        Text("Good job!\n\nYou got \(self.viewModel.correctCount) out of \(self.questions.count) questions right!")
                    } else {
                        Text("You got \(self.viewModel.correctCount) out of \(self.questions.count) questions right.\n\nPractice makes perfect!")
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
