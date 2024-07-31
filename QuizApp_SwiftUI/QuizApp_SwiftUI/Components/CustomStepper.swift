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
                if self.value > self.range.lowerBound {
                    self.value -= self.step
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
            }

            Text("\(self.value)")
                .font(.system(size: 22))
                .padding(.horizontal)

            Button(action: {
                if self.value < self.range.upperBound {
                    self.value += self.step
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.indigo) // To make the "+" button purple
            }
        }
    }
}
