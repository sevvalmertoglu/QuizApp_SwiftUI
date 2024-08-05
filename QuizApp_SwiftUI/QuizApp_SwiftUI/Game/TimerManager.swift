//
//  TimerManager.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 5.08.2024.
//

import Foundation

class TimerManager {
    private(set) var timeRemaining: Int
    private var timer: Timer?

    init(initialTime: Int = 10) {
        self.timeRemaining = initialTime
    }

    func start(with interval: TimeInterval = 1.0, onTick: @escaping (Int) -> Void, onComplete: @escaping () -> Void) {
        self.timer?.invalidate()
        self.timeRemaining = 10

        self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                onTick(self.timeRemaining)
            } else {
                self.stop()
                onComplete()
            }
        }
    }

    func stop() {
        self.timer?.invalidate()
    }
}
