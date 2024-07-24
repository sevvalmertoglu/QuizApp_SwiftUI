//
//  QuizApp_SwiftUIApp.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 16.07.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct QuizApp_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            let authViewModel = AuthViewModel(appState: appState)
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(appState)
        }
    }
}
