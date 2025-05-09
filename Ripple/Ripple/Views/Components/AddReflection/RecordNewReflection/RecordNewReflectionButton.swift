//
//  RecordNewReflectionButton.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct RecordNewReflectionButton: View {
    @ObservedObject var speechManager: SpeechRecognitionManager
    var submitAction: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            if speechManager.isCountingDown {
                // Countdown text display on the left of button
                Text("\(speechManager.countdownValue)...")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.red)
                    .frame(width: 100)
                    .multilineTextAlignment(.center)
            } else {
                Text(speechManager.isRecording ? "Currently recording..." : "Click to Record Response")
                    .font(.subheadlineMedium)
                    .frame(width: 100)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                speechManager.toggleRecording()
            }) {
                ZStack {
                    Circle()
                        .fill(speechManager.isRecording || speechManager.isCountingDown ? Color.red : Color.blue)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: speechManager.isRecording ? "stop.fill" : "mic.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
            }
            .disabled(!speechManager.isButtonEnabled || speechManager.isCountingDown)
            
            // Submit button that appears after recording stops
            if speechManager.showSubmitButton {
                Button(action: submitAction) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: speechManager.isRecording)
        .animation(.easeInOut, value: speechManager.showSubmitButton)
        .animation(.easeInOut, value: speechManager.isCountingDown)
        .animation(.easeInOut, value: speechManager.countdownValue)
    }
}

