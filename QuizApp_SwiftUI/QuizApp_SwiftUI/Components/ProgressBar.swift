//
//  ProgressBar.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import SwiftUI

struct ProgressBar: View {
    let percentComplete: Double
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    GeometryReader { innerGeometry in
                        RoundedRectangle(cornerRadius: 25) // This frame will be updated
                            .fill(Color.indigo)
                            .frame(width: innerGeometry.size.width * self.percentComplete)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.clear)
                    }
                }
                .frame(width: geometry.size.width * 0.95) // Takes up 95% of the screen
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray)
                }
                .frame(width: geometry.size.width) // Centers the view
            }
        }
        .frame(height: 10)
    }
}

#Preview {
    ProgressBar(percentComplete: 0.5)
}
