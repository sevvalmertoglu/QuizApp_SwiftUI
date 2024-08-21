//
//  CornerRadiusStyle.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 20.08.2024.
//

import Foundation
import SwiftUI

// Defining a shape and style for applying a corner rounding effect to specific corners
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: self.radius, corners: self.corners))
    }
}
