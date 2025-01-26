//
//  CalendarLegend.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/1/2025.
//

import SwiftUI

struct CalendarLegend: View {
    @ObservedObject var viewModel: StepDataViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            LegendBox(
                numDays: viewModel.getCompletedGoalDaysCount(),
                goalDescription: "100% of Goal Reached",
                goal: "4000+ Steps",
                backgroundColor: Color.goalReachedColour,
                isNonWearDay: false,
                isDisabled: viewModel.isLegendBoxDisabled(for: .goalCompleteDay),
                onPress: {
                    viewModel.toggleStepGoalFilter(filter: .goalCompleteDay)
                }
            )
            
            LegendBox(
                numDays: viewModel.getNumOverHalfGoalDays(),
                goalDescription: "Over 50% of Goal",
                goal: "More than 2000 Steps",
                backgroundColor: Color.overHalfColour,
                isNonWearDay: false,
                isDisabled: viewModel.isLegendBoxDisabled(for: .overHalfGoal),
                onPress: {
                    viewModel.toggleStepGoalFilter(filter: .overHalfGoal)
                }
            )
            
            LegendBox(
                numDays: viewModel.getNumUnderHalfGoalsDays(),
                goalDescription: "Under 50% of Goal",
                goal: "Less than 2000 Steps",
                backgroundColor: Color.underHalfColour,
                isNonWearDay: false,
                isDisabled: viewModel.isLegendBoxDisabled(for: .underHalfGoal),
                onPress: {
                    viewModel.toggleStepGoalFilter(filter: .underHalfGoal)
                }
            )
            
            LegendBox(
                numDays: viewModel.getNumNonWearDays(),
                goalDescription: "Non-Wear Day",
                backgroundColor: Color.gray.opacity(0.3),
                isNonWearDay: true,
                isDisabled: viewModel.isLegendBoxDisabled(for: .nonWearDay),
                onPress: {
                    viewModel.toggleStepGoalFilter(filter: .nonWearDay)
                }
            )
        }
        .padding()
    }
}
