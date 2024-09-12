//
//  NumberOfQuestionsView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//
import CoreAPI
import SwiftUI

struct GameSelectionView: View {
    @StateObject private var viewModel: GameSelectionViewModel
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false

    let triviaCategory: TriviaCategory

    let column = [
        GridItem(.flexible(maximum: 150)),
        GridItem(.flexible(maximum: 150))
    ]

    init(triviaCategory: TriviaCategory) {
        self.triviaCategory = triviaCategory
        _viewModel = StateObject(wrappedValue: GameSelectionViewModel(triviaCategory: triviaCategory))
    }

    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea([.all])
            VStack(spacing: 35) {
                VStack {
                    Text("Difficulty")
                        .font(.system(size: 26, weight: .medium))

                    LazyVGrid(columns: self.column, spacing: 20) {
                        OptionButton(
                            title: "Any",
                            action: {
                                self.viewModel.updateDifficulty(selected: .any)
                            },
                            isSelected: self.viewModel.isDifficultyActive(.any)
                        )

                        OptionButton(
                            title: "Easy",
                            action: {
                                self.viewModel.updateDifficulty(selected: .easy)
                            },
                            isSelected: self.viewModel.isDifficultyActive(.easy)
                        )

                        OptionButton(
                            title: "Medium",
                            action: {
                                self.viewModel.updateDifficulty(selected: .medium)
                            },
                            isSelected: self.viewModel.isDifficultyActive(.medium)
                        )

                        OptionButton(
                            title: "Hard",
                            action: {
                                self.viewModel.updateDifficulty(selected: .hard)
                            },
                            isSelected: self.viewModel.isDifficultyActive(.hard)
                        )
                    }
                }

                VStack {
                    Text("Question Type")
                        .font(.system(size: 26, weight: .medium))

                    LazyVGrid(columns: self.column, spacing: 20) {
                        OptionButton(
                            title: "Both",
                            action: {
                                self.viewModel.updateTriviaType(selected: .both)
                            },
                            isSelected: self.viewModel.isTriviaTypeActive(.both)
                        )

                        OptionButton(
                            title: "Multiple Choice",
                            action: {
                                self.viewModel.updateTriviaType(selected: .multipleChoice)
                            },
                            isSelected: self.viewModel.isTriviaTypeActive(.multipleChoice)
                        )
                    }

                    OptionButton(
                        title: "True / False",
                        action: {
                            self.viewModel.updateTriviaType(selected: .trueFalse)
                        },
                        isSelected: self.viewModel.isTriviaTypeActive(.trueFalse)
                    )
                }

                VStack {
                    Text("Number of questions")
                        .font(.system(size: 26, weight: .medium))

                    CustomStepper(value: self.$viewModel.numberOfQuestions, range: 1...25)
                        .padding()
                }

                NavigationLink(destination: QuestionsView(questions: self.$viewModel.questions), isActive: self.$viewModel.successfulLoad) {
                    Text("Start!")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color.backgroundColor)
                        .frame(width: 200, height: 50)
                        .background(Color.indigo)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .onTapGesture {
                            Task {
                                self.isLoading.toggle()
                                await self.viewModel.fetchTriviaQuestions()

                                // Show alert if there is an error
                                if !self.viewModel.errorMessage.isEmpty {
                                    self.showAlert = true
                                }

                                self.isLoading.toggle()
                            }
                        }
                        .overlay(alignment: .trailing) {
                            if self.isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(Color.backgroundColor)
                                    .frame(width: 50, height: 50)
                                    .scaleEffect(1.4)
                            }
                        }
                        .padding([.top])
                }

                if self.viewModel.errorMessage != "" {
                    Text(self.viewModel.errorMessage)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.red)
                }

                Spacer()
            }
            .navigationTitle(self.triviaCategory.name)
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: self.$showAlert) {
                Alert(
                    title: Text("Unexpected Error"),
                    message: Text("Questions could not be loaded. Please check your internet connection."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    GameSelectionView(triviaCategory: TriviaCategory(id: 9, name: "General Knowledge"))
        .preferredColorScheme(.dark)
}
