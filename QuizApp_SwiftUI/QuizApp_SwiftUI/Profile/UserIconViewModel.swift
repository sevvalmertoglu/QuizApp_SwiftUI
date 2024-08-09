//
//  UserIconViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 9.08.2024.
//

import FirebaseAuth
import Foundation
import SwiftUI

class UserIconViewModel: ObservableObject {
    let sections = [
        ("Animals", (1...6).map { "animal\($0)" }),
        ("Men", (1...6).map { "man\($0)" }),
        ("Women", (1...6).map { "woman\($0)" })
    ]

    @Published var selectedIndex: IndexPath? = nil
    @Published var showAlert = false
    @Published var alertMessage = ""

    func saveSelectedIcon() {
        guard let selectedIndex = selectedIndex else {
            self.alertMessage = NSLocalizedString("Please select an icon.", comment: "")
            self.showAlert = true
            return
        }

        let iconName = self.sections[selectedIndex.section].1[selectedIndex.item]
        guard let userId = Auth.auth().currentUser?.uid else { return }
        FirebaseManager.shared.saveUserIcon(userId: userId, iconName: iconName) { result in
            switch result {
            case .success():
                self.alertMessage = NSLocalizedString("Profile icon saved successfully.", comment: "")
            case let .failure(error):
                self.alertMessage = String(format: NSLocalizedString("Error saving profile icon: %@", comment: ""), error.localizedDescription)
            }
            self.showAlert = true
        }
    }
}
