//
//  ContextualFactors.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/2/2025.
//

import SwiftUI

struct ContextualFactors: View {
    let displayActivities: [(activityType: String, count: Int)]
    let displayEmotions: [(emotionType: String, count: Int)]
    
    
    var body: some View {
        HStack {
            // Left side - Activities
            VStack {
             Text("Top Activities")
                 .font(.headlineSemiBold)
                 .foregroundStyle(Color.redColour)
             HStack(spacing: 16) {
                 ForEach(Array(displayActivities.enumerated()), id: \.offset) { _, activity in
                     ContextualFactorsIcon(
                         icon: ActivityIcons(rawValue: activity.activityType)?.emoji ?? "❓",
                         title: ActivityIcons(rawValue: activity.activityType)?.label ?? "unknown",
                         quantity: String(activity.count)
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
                 ForEach(Array(displayEmotions.enumerated()), id: \.offset) { _, emotion in
                     ContextualFactorsIcon(
                         icon: EmotionIcons(rawValue: emotion.emotionType)?.emoji ?? "❓",
                         title: EmotionIcons(rawValue: emotion.emotionType)?.label ?? "unknown",
                         quantity: String(emotion.count)
                     )
                 }
             }
            }
        }
        .frame(width: 800, height: 200)
    }
}
