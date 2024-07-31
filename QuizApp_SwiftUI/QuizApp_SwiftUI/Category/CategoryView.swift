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

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea([.all])
            NavigationView {
                ZStack {
                    ScrollView {
                        Text("Please select a category")
                            .font(.system(size: 24, weight: .bold))
                        VStack(spacing: 15) {
                            ForEach(self.viewModel.categories, id: \.id) { category in
                                NavigationLink(destination: GameSelectionView(triviaCategory: category)) {
                                    GeometryReader { geometry in
                                        HStack {
                                            Text(self.viewModel.formatCategoryName(name: category.name))
                                                .font(.system(size: 22, weight: .bold))
                                                .foregroundColor(Color.backgroundColor)
                                                .padding()
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        .frame(width: geometry.size.width * 0.95, height: 60)
                                        .background(Color.indigo)
                                        .cornerRadius(15)
                                        .frame(width: geometry.size.width) // Center horizontally
                                    } // GeometryReader
                                    .frame(height: 50)
                                } // NavigationLink
                            } // ForEach
                        } // VStack
                    } // ScrollView
                } // ZStack
                .toolbar {
                    ToolbarItem {
                        Button(action: { self.lightMode.toggle() }) {
                            Image(systemName: self.lightMode == true ? "sun.max" : "moon.fill")
                                .font(.system(size: 20, weight: .medium))
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
        } // Root ZStack
        .preferredColorScheme(self.lightMode == true ? .light : .dark)
    }
}

#Preview {
    CategoryView()
}
