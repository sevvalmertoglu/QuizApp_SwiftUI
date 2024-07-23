//
//  CategoryView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject var categoryListViewModel : CategoryListViewModel
    @State private var selectedCategory: Category?
    
    init() {
        self.categoryListViewModel = CategoryListViewModel()
        self.categoryListViewModel.fetchCategory()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .font(.largeTitle)
                .bold()
                .padding(.top, 5)
                .padding(.leading, 16)
                .navigationBarBackButtonHidden(true)
            
            List(categoryListViewModel.categories) { category in
                Text(category.name)
                
            }.frame(height: 400)
                .listStyle(PlainListStyle())
        }
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    
}

#Preview {
    CategoryView()
}
