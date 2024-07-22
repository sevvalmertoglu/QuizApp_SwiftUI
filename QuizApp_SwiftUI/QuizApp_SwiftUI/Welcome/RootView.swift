//
//  RootView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 22.07.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showLoginView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                Text("Settings")
            }
        }.onAppear {
          
        }
    }
}

#Preview {
    RootView()
}
