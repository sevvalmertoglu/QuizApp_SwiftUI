//
//  AuthHeaderView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct AuthHeaderView: View {
    let title1: String
    let title2: String

    var body: some View {
        VStack(alignment: .center) {
            HStack { Spacer() }

            Text(self.title1)
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text(self.title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color.indigo)
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title1: "Hello", title2: "Welcome back")
    }
}

struct RoundedShape: Shape {
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))
        return Path(path.cgPath)
    }
}
