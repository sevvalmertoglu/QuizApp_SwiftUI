//
//  CategoryViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation
import CoreAPI

@MainActor final class CategoryViewModel: ObservableObject {
        @Published var selectedCategory: String
        @Published var categories: [TriviaCategory]
        @Published var errorMessage: String = ""
        @Published var triviaOptionsActive: Bool = false // False by default
        @Published var rootActive: Bool = true // True by default
        
        private let triviaService: TriviaService
        
        init() {
            selectedCategory = ""
            categories = []
            triviaService = TriviaService()
        }
        
        public func setupCategories() async -> Void {
            if !categories.isEmpty {
                return // Kategoriler zaten yüklendiyse tekrar yüklemeyin
            }
            
            let serviceResponse = await triviaService.fetchCategories()
            
            if let error = serviceResponse.error {
                errorMessage = error
                return
            }
            
            categories = serviceResponse.categories
        }
        
        public func formatCategoryName(name: String) -> String {
            return name.replacingOccurrences(of: "Entertainment: ", with: "")
        }
    }


