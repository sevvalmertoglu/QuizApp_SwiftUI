//
//  CategoryView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import CoreAPI
import SwiftUI

struct CategoryView: View {
    @StateObject private var viewModel = CategoryViewModel()
    @State private var lightMode: Bool = true
    @State private var searchText: String = ""

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
                Color.backgroundColor
                    .ignoresSafeArea([.all])
                NavigationView {
                    ZStack {
                        ScrollView {
                            Text("Please select a category")
                                .font(.system(size: 17, weight: .bold))
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 5) {
                                ForEach(self.searchResults, id: \.id) { category in
                                    NavigationLink(destination: GameSelectionView(triviaCategory: category)) {
                                        VStack {
                                            HStack {
                                                Text(self.viewModel.formatCategoryName(name: category.name))
                                                    .font(.system(size: 17, weight: .bold))
                                                    .foregroundColor(Color.backgroundColor)
                                                    .padding()
                                                    .multilineTextAlignment(.leading)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                Spacer()
                                            }
                                            .background(Color.indigo)
                                            .cornerRadius(15)
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem {
                            Button(action: { self.lightMode.toggle() }) {
                                Image(systemName: self.lightMode == true ? "sun.max" : "moon.fill")
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(self.lightMode == true ? Color.black : Color.white)
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            await self.viewModel.setupCategories()
                        }
                    }
                } // NavigationView
                .navigationViewStyle(.stack) // Prevents constraint error
        } // ZStack
        .preferredColorScheme(self.lightMode == true ? .light : .dark)
        .searchable(text: self.$searchText)
        
    }

    var searchResults: [TriviaCategory] {
        if self.searchText.isEmpty {
            return self.viewModel.categories
        } else {
            return self.viewModel.categories.filter { $0.name.localizedCaseInsensitiveContains(self.searchText) }
        }
    }
}

#Preview {
    CategoryView()
}
