//
//  UserIconView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 9.08.2024.
//

import SwiftUI

struct UserIconView: View {
    @StateObject private var viewModel = UserIconViewModel()
    @State private var isSavedUserIcon = false

    // 3 column grid layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            ForEach(0..<self.viewModel.sections.count, id: \.self) { sectionIndex in
                Section(header: Text(self.viewModel.sections[sectionIndex].0).font(.headline)) {
                    LazyVGrid(columns: self.columns, spacing: 20) {
                        ForEach(0..<self.viewModel.sections[sectionIndex].1.count, id: \.self) { itemIndex in
                            let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                            let iconName = self.viewModel.sections[sectionIndex].1[itemIndex]

                            ZStack(alignment: .bottomTrailing) {
                                Image(iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(self.viewModel.selectedIndex == indexPath ? Color.green : Color.clear, lineWidth: 5)
                                    )

                                if self.viewModel.selectedIndex == indexPath {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .onTapGesture {
                                self.viewModel.selectedIndex = indexPath
                            }
                        }
                    }
                    .padding(.bottom, 20) // Add padding between sections
                }
            }
            .padding()
        }
        .navigationTitle("Select an Icon")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.viewModel.saveSelectedIcon()
                    self.isSavedUserIcon = true
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(self.isSavedUserIcon ? .green : .gray)
                }
            }
        }
        .alert(isPresented: self.$viewModel.showAlert) {
            Alert(title: Text("Alert"), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    UserIconView()
}
