//
//  TrendsView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI
import CoreData

struct TrendsView: View {
    @StateObject private var viewModel: TrendsViewModel
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: TrendsViewModel(viewContext: viewContext))
        self.viewContext = viewContext
    }
    
    var body: some View {
        VStack(spacing: 16) {
            TrendsHeader()
            
            TimePeriodSelector(viewModel: viewModel)
            
            if viewModel.monthlyAverages.isEmpty {
                Spacer()
                ProgressView() // Show loading indicator
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                TrendsSummaryPanel(data: viewModel.displayData,
                                   selectedTimeRange: viewModel.selectedTimeRange,
                                   averageSteps: viewModel.averageStepsData,
                                   threeMonthTrends: viewModel.calculateThreeMonthTrends())
                    .animation(.easeInOut, value: viewModel.selectedTimeRange)
            }
            
            ContextualFactorsPanel(viewModel: viewModel)
        }
    }
}
