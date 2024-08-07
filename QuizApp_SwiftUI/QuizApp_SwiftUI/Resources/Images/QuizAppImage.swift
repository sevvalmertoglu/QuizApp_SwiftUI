//
//  QuizAppImage.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 7.08.2024.
//

import Foundation
import SwiftUI

public struct QuizAppImage: Equatable, Hashable {
    let resource: ImageResource

    init(resource: ImageResource) {
        self.resource = resource
    }

    public var asUIImage: UIImage {
        self.resource.uiImage
    }

    public var asImage: Image {
        self.resource.image
    }
}
