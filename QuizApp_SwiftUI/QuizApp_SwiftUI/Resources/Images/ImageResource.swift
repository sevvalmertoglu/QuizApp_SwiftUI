//
//  ImageResource.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 7.08.2024.
//

import Foundation
import SwiftUI

enum ImageResource: String {
    case background
    case backgroundGameOver
    case user

    var uiImage: UIImage {
        UIImage(named: self.rawValue) ?? UIImage()
    }

    var image: Image {
        Image(self.rawValue)
    }
}
