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
    let averageWearTime: Double
    let trendDescription: String
    let threeMonthTrends: (stepCount: (first: Double, second: Double), wearTime: (first: Double, second: Double))
    
    
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
    
    private var timePeriodInt: Int64 {
        switch selectedTimeRange {
        case .oneMonth:
            return 1
        case .threeMonths:
            return 3
        case .sixMonths:
            return 6
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
                
                
                Text("---- Your Daily Step Count Goal")
                    .font(.headlineSemiBold)
                    .foregroundStyle(Color.orangeColour)
                
            }
            
            HStack {
                StepCountBarChart(
                    data: data,
                    firstPeriodAverages: (
                        stepCount: threeMonthTrends.stepCount.first,
                        wearTime: threeMonthTrends.wearTime.first
                    ),
                    secondPeriodAverages: (
                        stepCount: threeMonthTrends.stepCount.second,
                        wearTime: threeMonthTrends.wearTime.second
                    )
                )
                TrendsInsightPanel(trendText: trendDescription,
                                   averageWearTime: averageWearTime,
                                   timePeriod: timePeriodInt)
            }
            
        }
        .frame(width: 1120, height: 380)
        .background(Color.grayColour)
        .cornerRadius(12)
    }
}
