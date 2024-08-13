//
//  CategoryViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import CoreAPI
import Foundation

@MainActor final class CategoryViewModel: ObservableObject {
    @Published var selectedCategory: String
    @Published var categories: [TriviaCategory]
    @Published var errorMessage: String = ""
    @Published var triviaOptionsActive: Bool = false // False by default
    @Published var rootActive: Bool = true // True by default

    private let triviaService: TriviaService

    init() {
        self.selectedCategory = ""
        self.categories = []
        self.triviaService = TriviaService()
    }

    public func setupCategories() async {
        if !self.categories.isEmpty {
            return
        }

        let serviceResponse = await triviaService.fetchCategories()

        if let error = serviceResponse.error {
            self.errorMessage = error
            return
        }

        self.categories = serviceResponse.categories
    }

    public func formatCategoryName(name: String) -> String {
        return name
    }
}
