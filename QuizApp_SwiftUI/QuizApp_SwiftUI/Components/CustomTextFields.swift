//
//  CustomTextFields.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.08.2024.
//

import SwiftUI

struct ProfileSettingsTextField: View {
    let icon: String
    let placeHolder: String
    @Binding var text: String

    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero

    var body: some View {
        HStack {
            TextField("", text: self.$text)
                .foregroundColor(.indigo)
                .font(.system(size: 20, weight: .bold))
                .padding(EdgeInsets(top: 15, leading: 60, bottom: 15, trailing: 60))
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            self.width = geo.size.width
                        }
                    }
                }
        }
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0, to: 0.55)
                    .stroke(.white, lineWidth: 1)

                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0.565 + (0.44 * (self.labelWidth / self.width)), to: 1)
                    .stroke(.white, lineWidth: 1)

                HStack {
                    Image(systemName: self.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.indigo)
                        .frame(width: 34, height: 34)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()

                Text(self.placeHolder)
                    .foregroundColor(.white)
                    .overlay {
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                self.labelWidth = geo.size.width
                            }
                        }
                    }
                    .padding(2)
                    .font(.system(size: 13, weight: .bold))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 20, y: -10)
            }
        }
    }
}
