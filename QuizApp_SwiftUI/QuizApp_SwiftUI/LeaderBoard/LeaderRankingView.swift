//
//  LeaderRankingView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 12.08.2024.
//

import SwiftUI

struct LeaderRankingView: View {
    let users = [
        ("Madelyn Dias", 590, "user"),
        ("Zain Vaccaro", 448, "user"),
        ("Skylar Geidt", 448, "user"),
        ("Justin Bator", 448, "user"),
        ("Cooper Lipshutz", 448, "user"),
        ("Alfredo Septimus", 448, "user"),
        ("Paityn Aminoff", 448, "user")
    ]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<self.users.count, id: \.self) { index in
                HStack {
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: 30, height: 30)

                        Text("\(index + 4)")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .frame(width: 40)

                    Image(self.users[index].2) // Placeholder for user image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .padding(.trailing, 10)

                    VStack(alignment: .leading) {
                        Text(self.users[index].0) // User name
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)

                        Text("\(self.users[index].1) points") // User points
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 3)
            }
        }
        .padding()
    }
}

#Preview {
    LeaderRankingView()
}
