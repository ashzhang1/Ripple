//
//  ContextualFactorsPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/1/2025.
//

import SwiftUI

struct ContextualFactorsPanel: View {
    @ObservedObject var viewModel: TrendsViewModel
    @ObservedObject var activityViewModel: ActivityDataViewModel
    @ObservedObject var emotionViewModel: EmotionDataViewModel
    @ObservedObject var commentViewModel: CommentDataViewModel
    
    
    /*
     Have to get these display activities and emotions as a computed variables bc
     they are dependent on the selected time period. (i.e., 1, 3 or 6 months)
     
     Bc im using synthetic json data between June 1 to November 30, start/end dates are hardcoded.
    */
    private var displayActivities: [(activityType: String, count: Int)] {
        let calendar = Calendar.current
        
        switch viewModel.selectedTimeRange {
        case .oneMonth:
            let startDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 1))!
            let endDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 30))!
            return activityViewModel.getTopActivitiesForPeriod(from: startDate, to: endDate)
            
        case .threeMonths:
            let startDate = calendar.date(from: DateComponents(year: 2024, month: 9, day: 1))!
            let endDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 30))!
            return activityViewModel.getTopActivitiesForPeriod(from: startDate, to: endDate)
            
        case .sixMonths:
            let startDate = calendar.date(from: DateComponents(year: 2024, month: 6, day: 1))!
            let endDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 30))!
            return activityViewModel.getTopActivitiesForPeriod(from: startDate, to: endDate)
        }
    }
    
    private var displayEmotions: [(emotionType: String, count: Int)] {
        let calendar = Calendar.current
        
        switch viewModel.selectedTimeRange {
        case .oneMonth:
            let startDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 1))!
            let endDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 30))!
            return emotionViewModel.getTopEmotionsForPeriod(from: startDate, to: endDate)
            
        case .threeMonths:
            let startDate = calendar.date(from: DateComponents(year: 2024, month: 9, day: 1))!
            let endDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 30))!
            return emotionViewModel.getTopEmotionsForPeriod(from: startDate, to: endDate)
            
        case .sixMonths:
            let startDate = calendar.date(from: DateComponents(year: 2024, month: 6, day: 1))!
            let endDate = calendar.date(from: DateComponents(year: 2024, month: 11, day: 30))!
            return emotionViewModel.getTopEmotionsForPeriod(from: startDate, to: endDate)
        }
    }
    
    
    
    var body: some View {
         VStack(spacing: 4) {
             
             // These are the buttons (clinician comments, supporter comments, contextual factors)
             InsightTypeSelector(viewModel: viewModel)

             
             // Show the component corresponding to currently selected insight type
             switch viewModel.selectedAdditionalInsightType {
             case .contextualFactors:
                 ContextualFactors(displayActivities: displayActivities,
                                 displayEmotions: displayEmotions)
             case .clinicianComments:
                 Comments(commentData: commentViewModel.clinicianCommentData)
             case .supporterComments:
                 Comments(commentData: commentViewModel.supporterCommentData)
             }
         }
    }
 }
