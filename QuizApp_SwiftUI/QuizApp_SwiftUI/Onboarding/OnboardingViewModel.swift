//
//  OnboardingViewModel.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 20.08.2024.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var onboardingPages: [Onboarding] = [
        Onboarding(
            imageName: QuizAppImages.instance.onboarding1.asImage,
            title: "Welcome to Quiz App!",
            description: "Get to know our app! Explore your favorite categories and questions, and enjoy a fun experience. If you’re ready to start, let’s go!"
        ),
        Onboarding(
            imageName: QuizAppImages.instance.onboarding2.asImage,
            title: "Rich Game Categories",
            description: "Our app offers a variety of game categories: Movies, books, nature, sports, music, and more! Discover games that suit your interests and have fun."
        ),
        Onboarding(
            imageName: QuizAppImages.instance.onboarding3.asImage,
            title: "Leaderboard and Scores",
            description: "Compete with others and climb to the top of the leaderboard. With our leaderboard, you can track your scores and see how you stack up against other users. Good luck!"
        )
    ]

    @Published var currentPageIndex: Int = 0
    @Published var shouldShowSplash: Bool = false

    func goToNextPage() {
        if self.currentPageIndex < self.onboardingPages.count - 1 {
            withAnimation {
                self.currentPageIndex += 1
            }
        } else {
            withAnimation {
                self.shouldShowSplash = true
                UserDefaults.standard.set(false, forKey: "isOnboarding")
            }
        }
    }

    func goToPreviousPage() {
        if self.currentPageIndex > 0 {
            withAnimation {
                self.currentPageIndex -= 1
            }
        }
    }

    func skipOnboarding() {
        withAnimation {
            self.shouldShowSplash = true
            UserDefaults.standard.set(false, forKey: "isOnboarding")
        }
    }
}
