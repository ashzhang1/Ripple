//
//  CalendarView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    @StateObject private var viewModel: StepDataViewModel
    @State private var showingStepInfo = false
    
    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: StepDataViewModel(viewContext: viewContext))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            CalendarHeader(showDates: $viewModel.showDates)
            
            HStack(alignment: .top, spacing: 20) {
                CalendarLegend(viewModel: viewModel)
                    .frame(width: 200)
                
                CalendarGrid(viewModel: viewModel)
                
                Spacer()
            }
            .padding(.horizontal)
            
            CalendarInfoButtons(showingStepInfo: $showingStepInfo)
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct CalendarGrid: View {
    @ObservedObject var viewModel: StepDataViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(viewModel.displayMonths.indices, id: \.self) { rowIndex in
                HStack(spacing: 20) {
                    ForEach(viewModel.displayMonths[rowIndex], id: \.self) { monthDate in
                        CalendarMonth(
                            date: monthDate,
                            showDates: viewModel.showDates,
                            stepData: viewModel.stepData,
                            goalCompleteThreshold: StepCountGoalThresholds.goalCompleteDay,
                            overHalfThreshold: StepCountGoalThresholds.overHalfGoal,
                            underHalfThreshold: StepCountGoalThresholds.underHalfGoal,
                            nonWearThreshold: StepCountGoalThresholds.nonWearDay
                        )
                    }
                }
            }
        }
    }
}

#Preview("11-inch iPad Pro", traits: .landscapeRight) {
    CalendarView(viewContext: PersistenceController.preview.container.viewContext)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


/**
 Below is the scroll view that allows to see the step count for each day (1 June - 30 November)
 ScrollView {
     if viewModel.isLoading {
         ProgressView()
             .frame(maxWidth: .infinity, maxHeight: .infinity)
     } else if let error = viewModel.error {
         VStack {
             Text("Error loading data")
                 .font(.headline)
             Text(error.localizedDescription)
                 .font(.subheadline)
                 .foregroundColor(.red)
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity)
     } else {
         LazyVStack(alignment: .leading, spacing: 8) {
             ForEach(viewModel.stepData) { stepData in
                 HStack {
                     Text(stepData.date, style: .date)
                         .font(.subheadline)
                         .foregroundColor(.gray)
                     Spacer()
                     Text("\(stepData.stepCount) steps")
                         .font(.headline)
                 }
                 .padding(.vertical, 4)
                 .padding(.horizontal)
                 .background(Color(UIColor.secondarySystemBackground))
                 .cornerRadius(8)
             }
         }
         .padding()
     }
 }
 .frame(maxWidth: .infinity)
 .refreshable {
     viewModel.refreshStepCount()
 }

 
 
 */
