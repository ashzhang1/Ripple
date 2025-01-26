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
    let topActivities: [(activityType: String, count: Int)]
    let topEmotions: [(emotionType: String, count: Int)]
    
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
    
    // Have to use this computed property because we cant directly use topActivities.
    // The view renders before the data loads causing view to crash
    private var displayActivities: [(activityType: String, count: Int)] {
        let emptyActivity = (activityType: "", count: 0)
        var activities = topActivities.prefix(3).map { $0 }
        
        while activities.count < 3 {
            activities.append(emptyActivity)
        }
        
        return activities
    }
    
    private var displayEmotions: [(emotionType: String, count: Int)] {
        let emptyEmotion = (emotionType: "", count: 0)
        var emotions = topEmotions.prefix(3).map { $0 }
        
        while emotions.count < 3 {
            emotions.append(emptyEmotion)
        }
        
        return emotions
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
                        HStack(spacing: 16) {
                            // Activity items with icons
                            ForEach(0..<3, id: \.self) { index in
                                ContextualFactorsIcon(
                                    icon: ActivityIcons(rawValue: displayActivities[index].activityType)?.emoji ?? "❓",
                                    title: ActivityIcons(rawValue: displayActivities[index].activityType)?.label ?? "unknown",
                                    quantity: String(displayActivities[index].count)
                                )
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Right side - Emotions
                    VStack {
                        Text("Top Emotions")
                            .font(.headlineSemiBold)
                            .foregroundStyle(Color.redColour)
                        HStack(spacing: 16) {
                            // Emotion items with icons
                            ForEach(0..<3, id: \.self) { index in
                                ContextualFactorsIcon(
                                    icon: EmotionIcons(rawValue: displayEmotions[index].emotionType)?.emoji ?? "❓",
                                    title: EmotionIcons(rawValue: displayEmotions[index].emotionType)?.label ?? "unknown",
                                    quantity: String(displayEmotions[index].count)
                                )
                            }
                        }
                    }
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text("Average Daily Wear-Time")
                        .font(.headlineSemiBold)
                        .foregroundStyle(Color.redColour)
                    Text(String(format: "%.1f", averageWearTimeForMonth) + " hours per day")
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
