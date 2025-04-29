//
//  ReflectionTextInput.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct ReflectionTextInput: View {
    @Binding var text: String
    var isRecording: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Text area with binding
            TextEditor(text: $text)
                .padding(8)
                .frame(height: 160)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isRecording ? Color.red : Color.gray, lineWidth: 1)
                )
            
            // Placeholder text that disappears when there's content
            if text.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Not sure where to start?")
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                    
                    Text("You could structure your reflections by answering:")
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• How did this month compare to the past months?")
                            .foregroundColor(.gray)
                        Text("• Are you proud with your current goal progress?")
                            .foregroundColor(.gray)
                        Text("• What would you like to do differently next month?")
                            .foregroundColor(.gray)
                    }
                }
                .padding(12)
            }
        }
    }
}
