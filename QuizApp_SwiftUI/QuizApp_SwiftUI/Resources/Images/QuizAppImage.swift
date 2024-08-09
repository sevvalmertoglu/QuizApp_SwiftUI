//
//  QuizAppImage.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 7.08.2024.
//

import Foundation
import SwiftUI

public struct QuizAppImage: Equatable, Hashable {
    let resourceName: String

    init(resourceName: String) {
        self.resourceName = resourceName
    }

    var asUIImage: UIImage {
        UIImage(named: self.resourceName) ?? UIImage()
    }

    var asImage: Image {
        Image(self.resourceName)
    }
}
