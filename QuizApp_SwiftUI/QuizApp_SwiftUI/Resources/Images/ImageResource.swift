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
    var Rank1: QuizAppImage { get }
    var Rank2: QuizAppImage { get }
    var Rank3: QuizAppImage { get }
    var backgroundLeaderBoard: QuizAppImage { get }
    var Medal1: QuizAppImage { get }
    var Medal2: QuizAppImage { get }
    var Medal3: QuizAppImage { get }
    var backgroundPreviousScores: QuizAppImage { get }
}
