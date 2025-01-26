//
//  LegendBox.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/1/2025.
//

import SwiftUI

struct LegendBox: View {
    let numDays: Int
    let goalDescription: String
    let goal: String?
    let backgroundColor: Color
    let isNonWearDay: Bool
    let isDisabled: Bool
    let onPress: () -> Void
    
    init(numDays: Int, goalDescription: String, goal: String? = nil, backgroundColor: Color, isNonWearDay: Bool, isDisabled: Bool, onPress: @escaping () -> Void) {
        self.numDays = numDays
        self.goalDescription = goalDescription
        self.goal = goal
        self.backgroundColor = backgroundColor
        self.isNonWearDay = isNonWearDay
        self.isDisabled = isDisabled
        self.onPress = onPress
    }
    
    var body: some View {
        Button(action: {
            onPress()
        }) {
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
                .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
                
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
        .disabled(isDisabled)
        .buttonStyle(PlainButtonStyle())
    }
}
