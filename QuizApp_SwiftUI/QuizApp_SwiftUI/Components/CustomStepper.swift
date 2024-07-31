//
//  CustomStepper.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 29.07.2024.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Int
    var range: ClosedRange<Int>
    var step: Int = 1

    var body: some View {
        HStack {
            Button(action: {
                if value > range.lowerBound {
                    value -= step
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
            }

            Text("\(value)")
                .font(.system(size: 22))
                .padding(.horizontal)

            Button(action: {
                if value < range.upperBound {
                    value += step
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.indigo) // To make the "+" button purple
            }
        }
    }
}
