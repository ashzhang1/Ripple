//
//  detailedMonthView.swift
//  Ripple
//
//  Created by Ashley Zhang on 13/1/2025.
//

import SwiftUI
import CoreData

struct DetailedMonthView: View {
    let date: Date
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var stepDataViewModel: StepDataViewModel
    @StateObject private var activityDataViewModel: ActivityDataViewModel
    @StateObject private var emotionDataViewModel: EmotionDataViewModel

    init(date: Date, viewModel: StepDataViewModel, viewContext: NSManagedObjectContext) {
        self.date = date
        self.stepDataViewModel = viewModel
        _activityDataViewModel = StateObject(wrappedValue: ActivityDataViewModel(viewContext: viewContext))
        _emotionDataViewModel = StateObject(wrappedValue: EmotionDataViewModel(viewContext: viewContext))
    }
    
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
                    stepData: stepDataViewModel.stepData,
                    goalCompleteThreshold: StepCountGoalThresholds.goalCompleteDay,
                    overHalfThreshold: StepCountGoalThresholds.overHalfGoal,
                    underHalfThreshold: StepCountGoalThresholds.underHalfGoal,
                    nonWearThreshold: StepCountGoalThresholds.nonWearDay,
                    selectedFilter: stepDataViewModel.selectedFilter
                )
                .padding(.horizontal)
                
                DetailedMonthContextualFactors(
                    date: date,
                    stepData: stepDataViewModel.stepData,
                    topActivities: activityDataViewModel.getTopActivitiesForMonth(date),
                    topEmotions: emotionDataViewModel.getTopEmotionsForMonth(date)
                )
            }
            
            
            DetailedMonthLegend(viewModel: stepDataViewModel, date: date)
                .padding(.horizontal)

            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }
}
