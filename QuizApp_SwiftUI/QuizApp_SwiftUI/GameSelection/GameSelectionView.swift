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

    let triviaCategory: TriviaCategory

    let column = [
        GridItem(.flexible(maximum: 150)),
        GridItem(.flexible(maximum: 150)),
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

                    LazyVGrid(columns: column, spacing: 20) {
                        OptionButton(
                            title: "Any",
                            action: {
                                viewModel.updateDifficulty(selected: .any)
                            },
                            isSelected: viewModel.isDifficultyActive(.any)
                        )

                        OptionButton(
                            title: "Easy",
                            action: {
                                viewModel.updateDifficulty(selected: .easy)
                            },
                            isSelected: viewModel.isDifficultyActive(.easy)
                        )

                        OptionButton(
                            title: "Medium",
                            action: {
                                viewModel.updateDifficulty(selected: .medium)
                            },
                            isSelected: viewModel.isDifficultyActive(.medium)
                        )

                        OptionButton(
                            title: "Hard",
                            action: {
                                viewModel.updateDifficulty(selected: .hard)
                            },
                            isSelected: viewModel.isDifficultyActive(.hard)
                        )
                    }
                }

                VStack {
                    Text("Question Type")
                        .font(.system(size: 26, weight: .medium))

                    LazyVGrid(columns: column, spacing: 20) {
                        OptionButton(
                            title: "Both",
                            action: {
                                viewModel.updateTriviaType(selected: .both)
                            },
                            isSelected: viewModel.isTriviaTypeActive(.both)
                        )

                        OptionButton(
                            title: "Multiple Choice",
                            action: {
                                viewModel.updateTriviaType(selected: .multipleChoice)
                            },
                            isSelected: viewModel.isTriviaTypeActive(.multipleChoice)
                        )
                    }

                    OptionButton(
                        title: "True / False",
                        action: {
                            viewModel.updateTriviaType(selected: .trueFalse)
                        },
                        isSelected: viewModel.isTriviaTypeActive(.trueFalse)
                    )
                }

                VStack {
                    Text("Number of questions")
                        .font(.system(size: 26, weight: .medium))

                    CustomStepper(value: $viewModel.numberOfQuestions, range: 1 ... 25)
                        .padding()
                }

                NavigationLink(destination: QuestionsView(questions: $viewModel.questions), isActive: $viewModel.successfulLoad) {
                    Text("Start!")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color.backgroundColor)
                        .frame(width: 200, height: 50)
                        .background(Color.indigo)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .onTapGesture {
                            Task {
                                isLoading.toggle()
                                await viewModel.fetchTriviaQuestions()
                                isLoading.toggle()
                            }
                        }
                        .overlay(alignment: .trailing) {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(Color.backgroundColor)
                                    .frame(width: 50, height: 50)
                                    .scaleEffect(1.4)
                            }
                        }
                        .padding([.top])
                }

                if viewModel.errorMessage != "" {
                    Text(viewModel.errorMessage)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.red)
                }

                Spacer()
            }
            .navigationTitle(triviaCategory.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GameSelectionView(triviaCategory: TriviaCategory(id: 9, name: "General Knowledge"))
        .preferredColorScheme(.dark)
}
