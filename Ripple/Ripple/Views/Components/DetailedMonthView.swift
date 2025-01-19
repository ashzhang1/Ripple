//
//  detailedMonthView.swift
//  Ripple
//
//  Created by Ashley Zhang on 13/1/2025.
//

import SwiftUI

struct DetailedMonthView: View {
    let date: Date
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: StepDataViewModel
    
    private var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Back Button
            Color.clear
                .frame(height: 0)
                .safeAreaInset(edge: .top) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .font(.headline)
                                Text("Back to Calendar")
                                    .font(.headline)
                            }
                        }
                        .foregroundColor(.blue)
                        .padding(.leading, 16)
                        
                        Spacer()
                    }
                    .frame(height: 44)
                    .padding(.top, 32)
                }
            
            
            Spacer()
            
            
            HStack {
                DetailedCalendarMonth(
                    date: date,
                    stepData: viewModel.stepData,
                    goalCompleteThreshold: StepCountGoalThresholds.goalCompleteDay,
                    overHalfThreshold: StepCountGoalThresholds.overHalfGoal,
                    underHalfThreshold: StepCountGoalThresholds.underHalfGoal,
                    nonWearThreshold: StepCountGoalThresholds.nonWearDay,
                    selectedFilter: viewModel.selectedFilter
                )
                .padding(.horizontal)
                
                DetailedMonthContextualFactors(
                    date: date,
                    stepData: viewModel.stepData
                )
            }
            
            
            DetailedMonthLegend(viewModel: viewModel, date: date)
                .padding(.horizontal)

            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }
}
