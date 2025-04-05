//
//  TaskCard.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/4/2025.
//

import SwiftUI

struct TaskCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Record Your Monthly Reflection")
                .font(.titleMedium)
            
            Text("Due November 30th")
                .font(.headline)
                .foregroundStyle(Color.fontGrayColour)
            
            HStack() {
                TrendCardStatusIndicator(isCompleted: false)
                
                Text("Record")
                    .font(.headlineMedium)
                    .underline()
            }
            
            
        }
        .frame(width: 500, height: 260)
        .background(Color.grayColour)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
    }
}
