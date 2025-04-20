//
//  ReflectionTextInput.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct ReflectionTextInput: View {
    @Binding var text: String
    var placeholder: String
    var isRecording: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Text area with binding
            TextEditor(text: $text)
                .padding(8)
                .frame(height: 120)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isRecording ? Color.red : Color.gray, lineWidth: 1)
                )
                .opacity(text.isEmpty && !placeholder.isEmpty ? 0.75 : 1)
            
            // Placeholder text that disappears when there's content
            if text.isEmpty && !placeholder.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
            }
        }
    }
}
