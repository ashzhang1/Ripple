//
//  TimePeriodSelector.swift
//  Ripple
//
//  Created by Ashley Zhang on 25/1/2025.
//

import SwiftUI

struct TimePeriodSelector: View {
    @ObservedObject var viewModel: TrendsViewModel
    
    var body: some View {
        HStack(spacing: 44) {
            
            ForEach(TrendsViewModel.TimeRange.allCases, id: \.self) { timeRange in
                Button(action: {
                    viewModel.selectedTimeRange = timeRange
                }) {
                    Text(timeRange.rawValue)
                        .underline(viewModel.selectedTimeRange == timeRange)
                        .foregroundColor(viewModel.selectedTimeRange == timeRange ? .blue : .gray)
                }
            }
        }
        .font(.headlineSemiBold)
    }
}
