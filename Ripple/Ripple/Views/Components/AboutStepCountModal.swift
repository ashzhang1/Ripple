//
//  AboutStepCountModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 6/1/2025.
//

import SwiftUI

struct AboutStepCountModal: View {
    @Binding var isPresented: Bool
    
    private var attributedText: AttributedString {
        var text = AttributedString("Step count is the number of steps you take throughout the day. Pedometers and digital activity trackers can help you determine your step count. These devices count steps for any activity that involves step-like movement, including walking, running, and even movement as you go about your daily activities.")
        
        if let range = text.range(of: "Step count") {
            text[range].foregroundColor = .blue //makes the step count phrase blue
        }
        
        return text
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // Header section with gray background
                VStack {
                    HStack {
                        Text("Why a Healthy Step Count Matters")
                            .font(.headlineMedium)
                        Spacer()
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "pip.exit")
                                .font(.title)
                                .foregroundColor(Color.redColour)
                        }
                    }
                    .padding()
                }
                .background(Color.grayColour)
                
                // Content section
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(attributedText)
                            .font(.subheadlineMedium)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                }
                
            }
        }
    }
}

// For the preview
struct StepCountInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        AboutStepCountModal(isPresented: .constant(true))
    }
}
