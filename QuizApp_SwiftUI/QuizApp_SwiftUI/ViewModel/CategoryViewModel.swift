//
//  CategoryViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import Foundation
import SwiftUI

class CategoryListViewModel: ObservableObject {
    
    @Published var categories = [Category]()
    
    let categoryManager = CategoryManager()
    
    func  fetchCategory() {
        categoryManager.getCategory { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let categoryArray):
                if let categoryArray = categoryArray {
                    DispatchQueue.main.async {
                        self.categories = categoryArray
                    }
                   
                }
            }
        }
    }
}
