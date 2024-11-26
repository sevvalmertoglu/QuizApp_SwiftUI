//
//  ImageResource.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 7.08.2024.
//

import Foundation
import SwiftUI

public protocol ImageResource {
    var background: QuizAppImage { get }
    var backgroundGameOver: QuizAppImage { get }
    var user: QuizAppImage { get }
    var Step1: QuizAppImage { get }
    var Step2: QuizAppImage { get }
    var Step3: QuizAppImage { get }
    var backgroundLeaderBoard: QuizAppImage { get }
    var Crown1: QuizAppImage { get }
    var Crown2: QuizAppImage { get }
    var Crown3: QuizAppImage { get }
    var backgroundPreviousScores: QuizAppImage { get }
    var back: QuizAppImage { get }
    var onboarding1: QuizAppImage { get }
    var onboarding2: QuizAppImage { get }
    var onboarding3: QuizAppImage { get }
    var rightButton: QuizAppImage { get }
    var backgroundGame: QuizAppImage { get }
}
