//
//  AboutStepCountModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 6/1/2025.
//

import SwiftUI

struct AboutStepCountModal: View {
    @Binding var isPresented: Bool
    
    private var stepCountText: AttributedString {
        var text = AttributedString("Step count is the number of steps you take throughout the day. Activity trackers can help you determine your step count for any activity that involves step-like movement, including walking, running, and even movement as you go about your daily activities.")
        
        if let range = text.range(of: "Step count") {
            text[range].foregroundColor = .blue //makes the step count phrase blue
        }
        
        return text
    }
    
    private var wearTimeText: AttributedString {
        var text = AttributedString("Non-wear days are those days where your activity tracker has recorded a wear-time below 4 hours. Obtaining a high wear-time is important as it ensures that you receive accurate step count data that you can trust.")
        
        if let range = text.range(of: "Non-wear days") {
            text[range].foregroundColor = .blue
        }
        
        if let range = text.range(of: "4 hours") {
            text[range].foregroundColor = .orange
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
                            VStack {
                                Image(systemName: "pip.exit")
                                    .font(.title)
                                    .foregroundColor(Color.redColour)
                                Text("Back")
                                    .font(.bodyCustomMedium)
                                    .foregroundColor(Color.redColour)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.grayColour)
                
                // Content section
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text(stepCountText)
                            .font(.headlineMedium)
                            .lineSpacing(8)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(wearTimeText)
                            .font(.headlineMedium)
                            .lineSpacing(8)
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
