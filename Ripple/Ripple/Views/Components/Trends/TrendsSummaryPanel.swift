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
    let threeMonthTrends: (firstThreeMonths: Double, secondThreeMonths: Double)
    
    @State private var isStepTrendSelected: Bool = false
    
    
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
                StepCountBarChart(data: data,
                                  showTrendLines: isStepTrendSelected, // From your state
                                  firstPeriodAverage: threeMonthTrends.firstThreeMonths,
                                  secondPeriodAverage: threeMonthTrends.secondThreeMonths)
                
                // Trend cards
//                VStack(spacing: 16) {
//                    TrendCard(isStepCounTrendCard: true,
//                              trendTitle: "Last 6 Months Step Count Trend",
//                              trendDescription: "Increasing since the last 3 months.",
//                              isSelected: isStepTrendSelected,
//                              onTap: { isStepTrendSelected.toggle()})
//                    
//                    TrendCard(isStepCounTrendCard: false,
//                              trendTitle: "Last 6 Months Wear-Time Trend",
//                              trendDescription: "5.6 hours average per day during the last 6 months.",
//                              isSelected: isStepTrendSelected,
//                              onTap: { isStepTrendSelected.toggle()})
//                }
                TrendsInsightPanel(averageStepTrend: "increasing",
                                   trendStartMonth: "August",
                                   averageWearTime: 6.5,
                                   timePeriod: 6)
            }
            
        }
        .frame(width: 1120, height: 380)
        .background(Color.grayColour)
        .cornerRadius(12)
    }
}
