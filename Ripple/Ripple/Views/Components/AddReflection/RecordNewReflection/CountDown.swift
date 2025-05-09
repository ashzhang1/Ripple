//
//  CountDown.swift
//  Ripple
//
//  Created by Ashley Zhang on 9/5/2025.
//

import SwiftUI

struct CountDown: View {
    @ObservedObject var speechManager: SpeechRecognitionManager
    
    var body: some View {
        ZStack {
            if speechManager.isCountingDown {
                // Semi-transparent background
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                // Countdown value
                VStack(spacing: 16) {
                    Text("\(speechManager.countdownValue)")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.white)
                    
                    // Countdown text below it
                    Text(speechManager.countdownValue == 1 ? "Starting Recording!" : "Get Ready...")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(40)
                .background(Color.blue.opacity(0.7))
                .cornerRadius(20)
            }
        }
        .animation(.easeInOut, value: speechManager.isCountingDown)
    }
}
