//
//  MonthlyReflectionCard.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct MonthlyReflectionCard: View {
    @State private var reflectionText: String = ""
    
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("November Reflection")
                .font(.titleSemiBold)
            
            Text("During the month of November, these were the top activities and emotions that you logged on Ripple!")
                .font(.headline)
            
            ActivitiesAndEmotionsReflection()
            
            Text("What stood out to you this November?")
                .font(.headlineMedium)
            
            ReflectionTextInput(text: $reflectionText, placeholder: "")
            
            RecordNewReflectionButton {
                // Need to add actual action implementation here later
                print("Starting voice recording...")
            }
            
            
        }
        .padding(20)
        .frame(width: 512, height: 680)
        .background(Color.grayColour)
        .cornerRadius(12)
    }
}
