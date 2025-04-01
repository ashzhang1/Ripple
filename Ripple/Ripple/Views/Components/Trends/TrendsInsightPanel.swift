//
//  TrendsInsightPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/4/2025.
//

import SwiftUI

struct TrendsInsightPanel: View {
    let averageStepTrend: String // "increasing", "decreasing", or "stable"
    let trendStartMonth: String // e.g., "August"
    let averageWearTime: Double // in hours
    let timePeriod: Int64 // in months
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Trends")
                .font(.subheadlineSemiBold)
                .foregroundColor(.darkBlueTitleColour)
            
            // Step count trend info
            VStack(alignment: .leading, spacing: 8) {
                Text("Your average step count has been ")
                + Text(averageStepTrend)
                    .foregroundColor(.blueTrendFontColour)
                    .fontWeight(.semibold)
                + Text(" since \(trendStartMonth).")
                
                Text("You are averaging \(String(format: "%.1f", averageWearTime)) hours of wear-time per day for the last \(String(timePeriod)) months.")
            }
            
            VStack {
                Text("Wear-Time")
                    .font(.subheadlineSemiBold)
                    .foregroundColor(.darkBlueTitleColour)
                
                HStack {
                    Text("Low")
                    Image("TrendsPageWearTimeLegend")
                    Text("High")
                }
            }
            .frame(maxWidth: .infinity) // These two lines centre this VStack
            .multilineTextAlignment(.center)
        }
        .padding(12)
        .frame(width: 320, height: 260, alignment: .top)
        .background(Color.lightBlueColour)
        .cornerRadius(16)
                        
    }
}
