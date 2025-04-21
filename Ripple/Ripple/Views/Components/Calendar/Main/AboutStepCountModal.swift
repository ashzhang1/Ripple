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
        var text = AttributedString("Step count is the total number of steps you take in a day. Try to reach 5,500 steps to complete your daily goal. Activity trackers count your steps by tracking movements like walking, and other daily activities.")
        
        if let range = text.range(of: "Step count") {
            text[range].foregroundColor = .blue //makes the step count phrase blue
        }
        
        if let range = text.range(of: "5,500") {
            text[range].foregroundColor = .blue
        }
        
        return text
    }
    
    private var wearTimeText: AttributedString {
        var text = AttributedString("A non-wear day occurs when your tracker is worn for less than 7 hours. Wearing it for longer gives you more accurate step count data!")
        
        if let range = text.range(of: "non-wear day") {
            text[range].foregroundColor = .blue
        }
        
        if let range = text.range(of: "7 hours") {
            text[range].foregroundColor = .blue
        }
        
        
        return text
    }
    
    private var encouragementText: AttributedString {
        var text = AttributedString("Remember! Consistently meeting the step count goal can help you improve your mobility, balance, and your overall health.")
        
        if let range = text.range(of: "Remember!") {
            text[range].foregroundColor = .blue
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
                                Text("Exit")
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
                        Text(encouragementText)
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
