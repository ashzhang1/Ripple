//
//  CalendarLegend.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/1/2025.
//

import SwiftUI

struct CalendarLegend: View {
    var body: some View {
        VStack(spacing: 16) {
            LegendBox(
                numDays: 66,
                goalDescription: "100% of Goal Reached",
                goal: "4000+ Steps",
                backgroundColor: Color.goalReachedColor,
                isNonWearDay: false
            )
            
            LegendBox(
                numDays: 45,
                goalDescription: "Over 50% of Goal",
                goal: "More than 2000 Steps",
                backgroundColor: Color.overHalfColor,
                isNonWearDay: false
            )
            
            LegendBox(
                numDays: 39,
                goalDescription: "Under 50% of Goal",
                goal: "Less than 2000 Steps",
                backgroundColor: Color.underHalfColor,
                isNonWearDay: false
            )
            
            LegendBox(
                numDays: 33,
                goalDescription: "Non-Wear Day",
                backgroundColor: Color.gray.opacity(0.3),
                isNonWearDay: true
            )
        }
        .padding()
    }
}
