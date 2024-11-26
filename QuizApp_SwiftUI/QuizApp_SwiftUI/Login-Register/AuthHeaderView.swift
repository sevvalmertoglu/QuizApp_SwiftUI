//
//  AuthHeaderView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct AuthHeaderView: View {
    let title1: LocalizedStringKey
    let title2: LocalizedStringKey

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color.indigo)
                .rotationEffect(Angle(degrees: 15))
            VStack(alignment: .center) {

                Text(self.title1)
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text(self.title2)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }.padding(.top, 30)
            .padding(.leading)
            .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 300)
        .offset(y: -40)
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title1: "Hello", title2: "Welcome back")
    }
}
