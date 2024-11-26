//
//  OnboardingView.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 20.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel() // viewModel to manage onboarding data

    var body: some View {
        ZStack {
            if self.viewModel.shouldShowSplash {
                SplashView()
            } else {
                QuizAppImages.instance.backgroundGame.asImage
                    .resizable()
                    .ignoresSafeArea(.all)

                Rectangle()
                    .cornerRadius(radius: 100, corners: [.topRight])
                    .cornerRadius(3)
                    .frame(maxHeight: 350)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .frame(maxHeight: .infinity, alignment: .bottom)

                VStack {
                    // SkipButton
                    Button(action: self.viewModel.skipOnboarding) {
                        Rectangle()
                            .frame(width: 60, height: 25)
                            .foregroundStyle(Color.textColor)
                            .cornerRadius(radius: 15, corners: [.topRight])
                            .cornerRadius(3)
                            .overlay {
                                Text("SKIP")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                                    .kerning(0.6)
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 30)
                    .buttonStyle(.plain)

                    // OnboardingPagesView
                    TabView(selection: self.$viewModel.currentPageIndex) {
                        ForEach(self.viewModel.onboardingPages.indices, id: \.self) {
                            index in
                            OnboardingPageView(page: self.viewModel.onboardingPages[index])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    HStack {
                        CustomPageIndicator(pageCount: self.viewModel.onboardingPages.count, currentPageIndex: self.viewModel.currentPageIndex)

                        Spacer()

                        if self.viewModel.currentPageIndex > 0 {
                            // PreviousPageButton
                            Button(action: self.viewModel.goToPreviousPage) {
                                QuizAppImages.instance.back.asImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }

                        // NextPageButton
                        Button(action: self.viewModel.goToNextPage) {
                            Rectangle()
                                .fill(.clear)
                                .frame(width: 50, height: 50)
                                .commonLinearGradient(colors: [.greenishGray, .oliveGreen])
                                .cornerRadius(10)
                                .cornerRadius(radius: 25, corners: [.topRight])
                                .shadow(color: .shadowColor, radius: 7.5, y: 5)
                                .overlay {
                                    QuizAppImages.instance.rightButton.asImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18)
                                }
                        }
                    }
                    .padding(EdgeInsets(top: 40, leading: 50, bottom: 30, trailing: 50))
                }
            }
        }
    }
}

// MARK: - OnboardingPageView is used to display individual onboarding pages

struct OnboardingPageView: View {
    let page: Onboarding
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            self.page.imageName
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 400, alignment: .trailing)

            Text(self.page.title)
                .font(.system(size: 24).weight(.semibold))
                .kerning(0.44)
                .lineSpacing(2.5)

            Rectangle()
                .foregroundStyle(.clear)
                .frame(width: 50, height: 3)
                .background(
                    Color.indigo
                )
                .cornerRadius(2)

            Text(self.page.description)
                .font(.system(size: 17))
                .kerning(0.28)
                .foregroundStyle(Color.textColor)
                .lineSpacing(5)
        }
        .padding(.horizontal, 50)
    }
}

// MARK: - CustomPageIndicator display page indicators

struct CustomPageIndicator: View {
    let pageCount: Int // total number of onboarding pages
    let currentPageIndex: Int // current selected page index

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<self.pageCount, id: \.self) {
                index in
                if self.currentPageIndex == index {
                    Circle()
                        .fill(.clear)
                        .frame(width: 15, height: 15)
                        .commonLinearGradient(colors: [.greenishGray, .oliveGreen])
                        .clipShape(Circle())
                        .shadow(color: .shadowColor, radius: 7.5, y: 5)
                } else {
                    Circle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(width: 15, height: 15)
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
