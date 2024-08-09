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
}
