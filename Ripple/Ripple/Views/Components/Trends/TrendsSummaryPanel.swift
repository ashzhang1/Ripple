//
//  TrendsSummaryPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 26/1/2025.
//

import SwiftUI

struct TrendsSummaryPanel: View {
    let data: [StepAverage]
    let selectedTimeRange: TrendsViewModel.TimeRange
    let averageSteps: Int
    
    
    private var timePeriodText: String {
        switch selectedTimeRange {
        case .oneMonth:
            return "1 Month Average: "
        case .threeMonths:
            return "3 Month Average: "
        case .sixMonths:
            return "6 Month Average: "
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 8) {
                (Text(timePeriodText)
                    .fontWeight(.semibold)
                    +
                    Text("\(averageSteps) Steps")
                )
                .font(.headline)
                .padding(.top, 12)
                
                
                Text("---- Your Goal")
                    .font(.headlineSemiBold)
                    .foregroundStyle(Color.redColour)
                
            }
            
            HStack {
                StepCountBarChart(data: data)
                
                // Trend cards will go here
                VStack(spacing: 16) {
                    TrendCard(isStepCounTrendCard: true,
                              trendTitle: "Step Count Trend",
                              trendDescription: "Increasing since the last 3 months.")
                    
                    TrendCard(isStepCounTrendCard: false,
                              trendTitle: "Wear-Time Adherence",
                              trendDescription: "5.6 hours average per day during the last 6 months.")
                }
            }
            
        }
        .frame(width: 1120, height: 420)
        .background(Color.grayColour)
        .cornerRadius(12)
    }
}
