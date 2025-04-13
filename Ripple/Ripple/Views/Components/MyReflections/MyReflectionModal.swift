//
//  MyReflectionModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/2/2025.
//

import SwiftUI

struct MyReflectionModal: View {
    @Environment(\.dismiss) private var dismiss
    let reflection: MonthlyReflectionDataEntry
    @ObservedObject var activitiesViewModel: ActivityDataViewModel
    @ObservedObject var emotionsViewModel: EmotionDataViewModel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
    
    // Compute top activities dynamically based on current view model data
    private var topActivities: [(activityType: String, count: Int)] {
        if let monthDate = reflection.monthAsDate {
            return activitiesViewModel.getTopActivitiesForMonth(monthDate)
        }
        return []
    }
    
    // Compute top emotions dynamically based on current view model data
    private var topEmotions: [(emotionType: String, count: Int)] {
        if let monthDate = reflection.monthAsDate {
            return emotionsViewModel.getTopEmotionsForMonth(monthDate)
        }
        return []
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
        NavigationView {
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading) {
                    
                    // Header
                    ReflectionModalHeader(
                        monthName: reflection.fullMonthName,
                        dismiss: dismiss
                    )
                    
                    // Only show date if it exists
                    if let date = reflection.recordedDate {
                        (Text("Recorded on: ")
                            .font(.subheadlineMedium)
                            .foregroundColor(Color.black)
                         +
                         Text(dateFormatter.string(from: date)))
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .padding()
                    }
                    
                    // Contextual Factors
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
                    .padding(.horizontal)
                    
                    // Reflection Question and Response
                    VStack(alignment: .leading, spacing: 24) {
                        if let reflectionQuestion = reflection.reflectionQuestion {
                            Text(reflectionQuestion)
                                .font(.subheadline)
                        }
                        
                        Text("Your Response:")
                            .foregroundColor(.redColour)
                            .font(.subheadlineMedium)
                        
                        if let reflectionResponse = reflection.reflectionResponse {
                            Text(reflectionResponse)
                                .font(.subheadline)
                        }
                    }
                    .padding() // Internal padding
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color.grayColour
                            .cornerRadius(8)
                    )
                    .padding(.horizontal, 24) // External padding
                    
                    Spacer()
                }
            }
            .onAppear {
                // Reload data when the modal appears
                Task {
                    await MainActor.run {
                        activitiesViewModel.loadActivityData()
                        emotionsViewModel.loadEmotionData()
                    }
                }
            }
        }
    }
}

private struct ReflectionModalHeader: View {
    let monthName: String
    let dismiss: DismissAction
    
    var body: some View {
        VStack {
            HStack {
                Text("\(monthName) Reflection")
                    .font(.titleMedium)
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    VStack {
                        Image(systemName: "pip.exit")
                            .font(.title)
                            .foregroundColor(Color.redColour)
                        Text("Exit")
                            .font(.bodyCustomMedium)
                            .foregroundColor(Color.redColour)
                    }
                }
            }
            .padding()
        }
        .background(Color.grayColour)
    }
}
