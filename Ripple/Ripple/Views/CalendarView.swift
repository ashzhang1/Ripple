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
    @State private var showingHelpInfo = false
    
    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: StepDataViewModel(viewContext: viewContext))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                CalendarHeader(showDates: $viewModel.showDates)
                
                HStack(alignment: .top, spacing: 20) {
                    CalendarLegend(viewModel: viewModel)
                        .frame(width: 200)
                    
                    CalendarGrid(viewModel: viewModel)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                CalendarInfoButtons(showingStepInfo: $showingStepInfo, showingHelpInfo: $showingHelpInfo)
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarHidden(true) // Without this, the show dates toggle gets disabled for some reason
        }
        
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
                            nonWearThreshold: StepCountGoalThresholds.nonWearDay,
                            selectedFilter: viewModel.selectedFilter
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
