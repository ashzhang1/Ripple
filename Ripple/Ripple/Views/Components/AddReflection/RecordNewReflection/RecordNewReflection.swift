//
//  RecordNewReflection.swift
//  Ripple
//
//  Created by Ashley Zhang on 16/4/2025.
//

import SwiftUI
import CoreData

struct RecordNewReflection: View {
    let viewContext: NSManagedObjectContext
    @StateObject private var stepDataViewModel: StepDataViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        _stepDataViewModel = StateObject(wrappedValue: StepDataViewModel(viewContext: viewContext))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            AddReflectionHeader()
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                        Text("Back")
                            .font(.headline)
                    }
                }
                .foregroundColor(.blue)
                .padding(.leading, 16)
                
                
                Spacer()
            }
            .padding(.top, 8)
            
            HStack() {
                
                RecordReflectionMonthLegend(viewModel: stepDataViewModel,
                                      date: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 30))!)


                DetailedCalendarMonth(
                    date: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 30))!,
                    stepData: stepDataViewModel.stepData,
                    goalCompleteThreshold: StepCountGoalThresholds.goalCompleteDay,
                    overHalfThreshold: StepCountGoalThresholds.overHalfGoal,
                    underHalfThreshold: StepCountGoalThresholds.underHalfGoal,
                    nonWearThreshold: StepCountGoalThresholds.nonWearDay,
                    selectedFilter: stepDataViewModel.selectedFilter
                )
                    
                MonthlyReflectionCard()
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }
}
