//
//  AnswerBox.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//
import AVFoundation
import CoreAPI
import SwiftUI

struct AnswerBox: View {
    // Parameters
    let possibility: Answer
    @Binding var selectedUUID: UUID // Relays to QuestionView of selection is incorrect / correct
    @Binding var clickedComplete: Bool
    @Binding var selectionCorrect: Bool
    var nextClicked: () -> Void
    
    // Private properties
    @State private var wasSelected: Bool = false // Highlights only the selected box
    @State private var audioPlayer: AVAudioPlayer?
    
    var selectionIcon: String {
        let isCorrectAnswer = (clickedComplete && !possibility.incorrect)
        return isCorrectAnswer ? "checkmark" : "xmark"
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Button(action: {
                    if possibility.incorrect == false {
                        selectionCorrect = true
                        playSound(named: "correct")
                    }
                    else {
                        playSound(named: "incorrect")
                    }
                    withAnimation(.easeOut(duration: 0.1)) {
                        clickedComplete = true
                        wasSelected = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        nextClicked() // To call the nextClicked function after 1 second
                    }
                }) {
                    HStack(spacing: 0) {
                        Text(possibility.text)
                            .font(.system(size: 24, weight: .medium))
                            .minimumScaleFactor(0.3)
                            .lineLimit(nil)
                            .foregroundColor(Color.black)
                            .padding(4)
                            .padding([.leading], wasSelected ? 40 : 0)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                        if wasSelected {
                            Image(systemName: self.selectionIcon)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color.white)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: 60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.indigo, lineWidth: 4)
                    }
                } // button
                .background(markCorrect())
                .cornerRadius(12)
                .frame(width: geometry.size.width) // Centers the ZStack
            }
            .frame(height: 60)
        }
    }
    
    func markCorrect() -> Color {
        if clickedComplete == true && possibility.incorrect == false { // Correct; display correct unconditionally
            return Color.green // Returns green color unconditionally after clicked complete was finished
        }
        
        if wasSelected == true && possibility.incorrect == true { // Mark the incorrect button that was selected
            return Color.red // Return red if selected was incorrect
        }
        
        return Color.white // Returns white by default (non-selected)
    }
    
    func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not play sound file.")
        }
    }
}
