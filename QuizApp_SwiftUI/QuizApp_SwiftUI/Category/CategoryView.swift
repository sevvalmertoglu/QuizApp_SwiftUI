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
                            ForEach(viewModel.categories, id: \.id) { category in
                                NavigationLink(destination: GameSelectionView(triviaCategory: category)) {
                                    GeometryReader { geometry in
                                        HStack {
                                            Text(viewModel.formatCategoryName(name: category.name))
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
                }// ZStack
                .toolbar {
                    ToolbarItem {
                        Button(action: { lightMode.toggle() }) {
                            Image(systemName: lightMode == true ? "sun.max" : "sun.max.fill")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(lightMode == true ? Color.black : Color.white)
                        }
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.setupCategories()
                    }
                }
            } // NavigationView
            .navigationViewStyle(.stack) // Prevents constraint error
        } // Root ZStack
        .preferredColorScheme(lightMode == true ? .light : .dark)
    }
}

#Preview {
    CategoryView()
}
