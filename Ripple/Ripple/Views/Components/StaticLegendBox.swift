//
//  StaticLegendBox.swift
//  Ripple
//
//  Created by Ashley Zhang on 15/1/2025.
//

import SwiftUI

struct StaticLegendBox: View {
    let numDays: Int
    let goalDescription: String
    let goal: String?
    let backgroundColor: Color
    let isNonWearDay: Bool
    
    
    init(numDays: Int, goalDescription: String, goal: String? = nil, backgroundColor: Color, isNonWearDay: Bool) {
        self.numDays = numDays
        self.goalDescription = goalDescription
        self.goal = goal
        self.backgroundColor = backgroundColor
        self.isNonWearDay = isNonWearDay
    }
    
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 0) {
                Text("\(numDays)")
                    .font(.subheadlineBold)
                Text("Days")
                    .font(.subheadline)
            }
            .frame(width: 64, height: 64)
            .background(
                Group {
                    if isNonWearDay {
                        NonWearDayBoxPattern()
                    } else {
                        backgroundColor
                    }
                }
            )
            .cornerRadius(4)
            
            // Description text
            VStack {
                Text(goalDescription)
                    .font(.bodyCustomMedium)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 175)
                
                //if there is a goal then display it (non wear days have no goal)
                if let goal = goal {
                    Text(goal)
                        .font(.bodyCustom)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 175)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
