//
//  ContentView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 16.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var categoryListViewModel : CategoryListViewModel
    
    init() {
        self.categoryListViewModel = CategoryListViewModel()
        self.categoryListViewModel.fetchCategory()
    }
    
    var body: some View {
        List(categoryListViewModel.categories, id: \.id) {category in
            Text(category.name)
            
        }
    }
}

#Preview {
    ContentView()
}
