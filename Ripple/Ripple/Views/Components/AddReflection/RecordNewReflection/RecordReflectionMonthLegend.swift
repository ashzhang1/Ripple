//
//  GridLayoutMonthLegend.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct RecordReflectionMonthLegend: View {
    @ObservedObject var viewModel: StepDataViewModel
    let date: Date
        
    // This is to count num days for each category in the specific month
    private func countDaysInMonth(for category: StepGoalFilter) -> Int {
        return viewModel.stepData
            .filter { stepEntry in
                // First, just get the days for the current month we're on
                Calendar.current.isDate(stepEntry.date, equalTo: date, toGranularity: .month)
            }
            .filter { stepEntry in
                // Then filter for the category
                switch category {
                case .goalCompleteDay:
                    return stepEntry.wearTime >= StepCountGoalThresholds.nonWearDay &&
                           stepEntry.stepCount >= StepCountGoalThresholds.goalCompleteDay
                case .overHalfGoal:
                    return stepEntry.wearTime >= StepCountGoalThresholds.nonWearDay &&
                           stepEntry.stepCount >= StepCountGoalThresholds.overHalfGoal &&
                           stepEntry.stepCount < StepCountGoalThresholds.goalCompleteDay
                case .underHalfGoal:
                    return stepEntry.wearTime >= StepCountGoalThresholds.nonWearDay &&
                           stepEntry.stepCount < StepCountGoalThresholds.overHalfGoal
                case .nonWearDay:
                    return stepEntry.wearTime < StepCountGoalThresholds.nonWearDay
                }
            }
            .count
    }
    
    
    var body: some View {
        VStack(spacing: 12) {
            StaticLegendBox(
                numDays: countDaysInMonth(for: .goalCompleteDay),
                goalDescription: "100% of Goal Reached",
                goal: "5500+ Steps",
                backgroundColor: Color.goalReachedColour,
                isNonWearDay: false
            )
            
            StaticLegendBox(
                numDays: countDaysInMonth(for: .overHalfGoal),
                goalDescription: "Over 50% of Goal",
                goal: "More than 2750 Steps",
                backgroundColor: Color.overHalfColour,
                isNonWearDay: false
            )
            
            StaticLegendBox(
                numDays: countDaysInMonth(for: .underHalfGoal),
                goalDescription: "Under 50% of Goal",
                goal: "Less than 2750 Steps",
                backgroundColor: Color.underHalfColour,
                isNonWearDay: false
            )
            
            StaticLegendBox(
                numDays: countDaysInMonth(for: .nonWearDay),
                goalDescription: "Non-Wear Day",
                goal: "Less than 7hrs Wear-Time",
                backgroundColor: Color.gray.opacity(0.3),
                isNonWearDay: true
            )
        }
        .padding()
    }
}
