//
//  LeaderRankingView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 12.08.2024.
//

import SwiftUI

struct LeaderRankingView: View {
    @StateObject private var viewModel = LeaderRankingViewModel()
    var namespace: Namespace.ID
    @Environment(\.dismiss) private var dismiss
    @Binding var shouldShownSheet: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        self.shouldShownSheet.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 25)
                        .padding([.top, .trailing], 25)
                        .matchedGeometryEffect(id: "heroButton", in: self.namespace) // Hero effect
                })
            }
            VStack {
                ForEach(0..<self.viewModel.otherUsers.count, id: \.self) { index in
                    HStack {
                        ZStack {
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                                .frame(width: 30, height: 30)

                            Text("\(index + 4)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .frame(width: 40)

                        Image(self.viewModel.otherUsers[index].userIcon) // User image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing, 10)

                        VStack(alignment: .leading) {
                            Text(self.viewModel.otherUsers[index].nickname) // User name
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)

                            Text("\(self.viewModel.otherUsers[index].totalScore) point") // User points
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
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .cornerRadius(50)
    }
}
