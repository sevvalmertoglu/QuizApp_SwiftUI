//
//  CategoryView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryListViewModel: CategoryListViewModel
    @State private var selectedCategory: Category?
    @State var showTypeView = false
    
    init() {
        self.categoryListViewModel = CategoryListViewModel()
        self.categoryListViewModel.fetchCategory()
    }
    
    var body: some View {
        VStack {
            Text("Please select a category").font(.headline)
            
            VStack {
                List(self.categoryListViewModel.categories) { category in
                    Text(category.name)
                    
                }.frame(height: 420)
                    .listStyle(PlainListStyle())
            }
            NavigationLink(destination: TypeView()) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 140, height: 50)
                    .background(Color.indigo)
                    .clipShape(Capsule())
                    .padding()
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }
            .buttonStyle(PlainButtonStyle())
            .position(x: 200, y: 190)
        }
        .navigationTitle("Categories")
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    CategoryView()
}
