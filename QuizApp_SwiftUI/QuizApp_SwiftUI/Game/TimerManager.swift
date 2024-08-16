//
//  TimerManager.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 5.08.2024.
//

import Combine
import Foundation

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int
    private var timer: AnyCancellable?

    init(initialTime: Int = 10) {
        self.timeRemaining = initialTime
    }

    func start(with interval: TimeInterval = 1.0, onComplete: @escaping () -> Void) {
        self.timer?.cancel()
        self.timeRemaining = 10

        self.timer = Timer.publish(every: interval, on: .main, in: .common)
            // Combine framework
            .autoconnect() // To start the timer broadcast automatically
            .sink { [weak self] _ in // sink -> subscriber. Updates the countdown (timeRemaining) value
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stop()
                    onComplete()
                }
            }
    }

    func stop() {
        self.timer?.cancel()
    }
}
