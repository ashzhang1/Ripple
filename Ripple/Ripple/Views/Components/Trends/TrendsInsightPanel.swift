//
//  TrendsInsightPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/4/2025.
//

import SwiftUI

struct TrendsInsightPanel: View {
    let trendText: String // Hard-coded string from the trends view model
    let averageWearTime: Double // in hours
    let timePeriod: Int64 // in months
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Trends")
                .font(.subheadlineSemiBold)
                .foregroundColor(.darkBlueTitleColour)
            
            // Step count trend info
            VStack(alignment: .leading, spacing: 8) {
                Text("\(trendText)")
                    .font(.system(size: 18))
                
                Text("You are averaging \(String(format: "%.1f", averageWearTime)) hours of wear-time per day for the last \(String(timePeriod)) month(s).")
                    .font(.system(size: 18))
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
        .frame(width: 320, height: 280, alignment: .top)
        .background(Color.lightBlueColour)
        .cornerRadius(16)
                        
    }
}
