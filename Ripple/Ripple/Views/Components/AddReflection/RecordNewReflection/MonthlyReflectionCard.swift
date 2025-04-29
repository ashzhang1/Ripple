//
//  MonthlyReflectionCard.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct MonthlyReflectionCard: View {
    @EnvironmentObject var reflectionViewModel: MonthlyReflectionDataViewModel
    @StateObject private var speechManager = SpeechRecognitionManager()
    @State private var showSuccessAlert = false
    @State private var reflectionText: String = ""
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("November Reflection")
                .font(.titleSemiBold)
            
            Text("During the month of November, these were the top activities and emotions that you logged on Ripple!")
                .font(.headline)
            
            ActivitiesAndEmotionsReflection()
            
            Text("What stood out to you this November?")
                .font(.headlineMedium)
            
            ReflectionTextInput(
                text: $speechManager.transcribedText,
                isRecording: speechManager.isRecording
            )
            
            RecordNewReflectionButton(
                speechManager: speechManager,
                submitAction: {
                    submitReflection()
                }
            )
            
            if reflectionViewModel.isSaving {
                ProgressView()
                    .padding(.top, 8)
            }
            
            
        }
        .padding(20)
        .frame(width: 512, height: 680)
        .background(Color.grayColour)
        .cornerRadius(12)
        .alert("Reflection Saved", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your November reflection has been saved successfully.")
        }
        .onDisappear {
            // Clean up speech resources when view disappears
            speechManager.cleanup()
        }
    }
    
    private func submitReflection() {
        // Save the transcribed text to Core Data
        Task {
            let success = await reflectionViewModel.saveReflection(
                reflectionText: speechManager.transcribedText
            )
            
            if success {
                // Show success alert and reset the UI
                await MainActor.run {
                    showSuccessAlert = true
                    speechManager.transcribedText = ""
                    speechManager.showSubmitButton = false
                }
            }
        }
    }
}
