//
//  DetailedMonthContextualFactors.swift
//  Ripple
//
//  Created by Ashley Zhang on 17/1/2025.
//

import SwiftUI

struct DetailedMonthContextualFactors: View {
    let date: Date
    let stepData: [StepDataEntry]
    
    private var averageWearTimeForMonth: Double {
        
        // Filter step data for current month
        let wearTimeInMonth = stepData.filter { stepEntry in
            Calendar.current.isDate(stepEntry.date, equalTo: date, toGranularity: .month)
        }
        
        // Calculate average
        let totalWearTime = wearTimeInMonth.reduce(0) { $0 + $1.wearTime }
        let daysCount = wearTimeInMonth.count
        
        // Return 0 if no data
        guard daysCount > 0 else { return 0 }
        
        return (totalWearTime / Double(daysCount)).rounded()
    }
    
    var body: some View {
        VStack {
            Text("What Influenced Your Step Count")
                .font(.titleMedium)
            
            // Contextual factors
            VStack {
                HStack {
                    // Left side - Activities
                    VStack {
                        Text("Top Activities")
                            .font(.headlineSemiBold)
                            .foregroundStyle(Color.redColour)
                        HStack {
                            // Activity items with icons
                            ContextualFactorsIcon(icon: "🚶‍♂️", title: "Walking", quantity: "18")
                            ContextualFactorsIcon(icon: "🙆‍♀️", title: "Stretching", quantity: "15")
                            ContextualFactorsIcon(icon: "🏋️‍♂️", title: "Gym", quantity: "12")
                        }
                    }
                    
                    Spacer()
                    
                    // Right side - Emotions
                    VStack {
                        Text("Top Emotions")
                            .font(.headlineSemiBold)
                            .foregroundStyle(Color.redColour)
                        HStack {
                            // Emotion items with icons
                            ContextualFactorsIcon(icon: "😆", title: "Motivated", quantity: "17")
                            ContextualFactorsIcon(icon: "😀", title: "Happy", quantity: "16")
                            ContextualFactorsIcon(icon: "🥱", title: "Tired", quantity: "10")
                        }
                    }
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text("Average Daily Wear-Time")
                        .font(.headlineSemiBold)
                        .foregroundStyle(Color.redColour)
                    Text(String(format: "%.1f", averageWearTimeForMonth))
                        .font(.subheadlineMedium)
                }
            }
            .padding(.horizontal, 44)
            .padding(.vertical, 32)
            .frame(width: 650, height: 300)
            .background(Color.grayColour)
            .cornerRadius(12)
        }
    }
}

//#Preview("11-inch iPad Pro", traits: .landscapeRight) {
//    DetailedMonthContextualFactors()
//}
