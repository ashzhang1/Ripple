//
//  TrendsSummaryPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 26/1/2025.
//

import SwiftUI

struct TrendsSummaryPanel: View {
    let data: [StepAverage]
    
    var body: some View {
        VStack {
            HStack {
                StepCountBarChart(data: data)
                
                // Trend cards will go here
                VStack(spacing: 16) {
                            
                }
            }
            
        }
        .frame(width: 1120, height: 400)
        .background(Color.grayColour)
        .cornerRadius(12)
    }
}
