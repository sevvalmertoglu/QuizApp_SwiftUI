//
//  Onboarding.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 20.08.2024.
//

import Foundation
import SwiftUI

struct Onboarding: Identifiable {
    let id = UUID()
    let imageName: Image
    let title: LocalizedStringKey
    let description: LocalizedStringKey
}
