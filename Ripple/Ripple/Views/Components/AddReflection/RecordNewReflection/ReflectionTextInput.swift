//
//  ReflectionTextInput.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct ReflectionTextInput: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Not sure where to start?")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("You could reflect on questions like:")
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(["How did this month compare to the past months?",
                                "Are you proud with your current goal progress?",
                                "What would you like to do differently next month?"], id: \.self) { question in
                            HStack(alignment: .top) {
                                Text("•")
                                    .foregroundColor(.secondary)
                                Text(question)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.leading, 4)
                }
                .padding(12)
            }
            
            TextEditor(text: $text)
                .padding(8)
                .background(Color.clear)
                .opacity(text.isEmpty ? 0.25 : 1)
        }
        .frame(height: 220)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(Color.white.cornerRadius(8))
        )
    }
}
