//
//  AppState.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 23.07.2024.
//

import FirebaseAuth
import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var isUserLoggedIn: Bool = false

    init() {
        self.isUserLoggedIn = Auth.auth().currentUser != nil
    }
}
