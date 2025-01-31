//
//  TrendsViewModel.swift
//  Ripple
//
//  Created by Ashley Zhang on 25/1/2025.
//

import Foundation
import CoreData

class TrendsViewModel: ObservableObject {
    enum TimeRange: String, CaseIterable {
        case oneMonth = "1 Month"
        case threeMonths = "3 Months"
        case sixMonths = "6 Months"
    }
    
    enum AdditionalInsightType: String, CaseIterable {
        case clinicianComments = "Clinician Commments"
        case supporterComments = "Supporter Comments"
        case contextualFactors = "Contextual Factors"
    }
    
    @Published private(set) var stepData: [StepDataEntry] = []
    @Published private(set) var weeklyAverages: [StepAverage] = [] // For 1M view
    @Published private(set) var monthlyAverages: [StepAverage] = [] // For 6M view - for the 3M view, just use suffix(3)
    @Published var selectedTimeRange: TimeRange = .sixMonths
    @Published var selectedAdditionalInsightType: AdditionalInsightType = .contextualFactors
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    @Published private(set) var trendDirection: TrendDirection = .maintaining
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Task {
            await loadStepData()
            await MainActor.run {
                loadSelectedRangeData() // We have to wait for load step data to successfully run first
            }
        }
    }
    
    @MainActor
    private func loadStepData() {
        isLoading = true
        
        do {
            let request = NSFetchRequest<StepData>(entityName: "StepData")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \StepData.date, ascending: true)]
            
            let results = try viewContext.fetch(request)
            self.stepData = results.compactMap { coreDataItem in
                guard let id = coreDataItem.id,
                      let date = coreDataItem.date else { return nil }
                
                return StepDataEntry(
                    id: id,
                    date: date,
                    stepCount: Int(coreDataItem.stepCount),
                    wearTime: coreDataItem.wearTime
                )
            }
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    
    func loadSelectedRangeData() {
        calculateWeeklyAverages()
        calculateSixMonthAverages()
    }
    
    // Calculate last 4 weeks averages for 1M view
    private func calculateWeeklyAverages() {
        
        let calendar = Calendar.current
                
        // Get the latest date
        guard let latestDate = stepData.map({ $0.date }).max() else {
            weeklyAverages = []
            return
        }
       
        // Find the start of the current week
        // Four weeks ago is actually 3 weeks + current week
        guard let currentWeekStart = calendar.startOfWeek(for: latestDate),
             let fourWeeksAgo = calendar.date(byAdding: .weekOfYear, value: -3, to: currentWeekStart) else {
                return
        }
        
        // Create a dictionary and then filter the data to only the days are within 4 weeks
        var weeklyData: [Date: [Int]] = [:]
        let fourWeekData = stepData.filter { $0.date >= fourWeeksAgo }

        for entry in fourWeekData {
            
            // Get the start of the week for this entry
            if let weekStart = calendar.startOfWeek(for: entry.date) {
                weeklyData[weekStart, default: []].append(entry.stepCount)
            }
        }
        
        // This is needed for the label
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"

        weeklyAverages = weeklyData.map { (date, steps) in
            let average = Double(steps.reduce(0, +)) / Double(steps.count)
            
            // Calculate the end date --> 6 days because inclusive
            guard let endDate = Calendar.current.date(byAdding: .day, value: 6, to: date) else {
                return StepAverage(period: date, average: average, label: "Invalid date")
            }
            
            // Label for the bar
            let startDateString = dateFormatter.string(from: date)
            let endDateString = dateFormatter.string(from: endDate)
            
            return StepAverage(
                period: date,
                average: average,
                label: "\(startDateString) - \(endDateString)"
            )
        }
        .sorted { $0.period < $1.period }
        
    }
    
    // Calculate last 6 months averages for 6M view
    // This just calculates the average per month for the whole step data
    // A bit sketch but its ok because I only have 6 months of json data
    private func calculateSixMonthAverages() {
        let calendar = Calendar.current
        var monthlyData: [Date: [Int]] = [:]
        
        // No need to filter for date range since we know we have 6 months
        for entry in stepData {
            if let monthStart = calendar.startOfMonth(for: entry.date) {
                monthlyData[monthStart, default: []].append(entry.stepCount)
            }
        }
        
        // Format month names
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM" // "Jan", "Feb", etc.
        
        monthlyAverages = monthlyData.map { (date, steps) in
            let average = Double(steps.reduce(0, +)) / Double(steps.count)
            return StepAverage(
                period: date,
                average: average,
                label: dateFormatter.string(from: date)
            )
        }
        .sorted { $0.period < $1.period }

    }
    
    
    // This is to determine which time period is currently selected
    func isTimeRangeDisabled(for timeRange: TimeRange) -> Bool {
        return timeRange != selectedTimeRange
    }
    
    
    // This is the currently displayed data on the bar chart which depends on the time period
    var displayData: [StepAverage] {
        switch selectedTimeRange {
        case .oneMonth:
            return weeklyAverages
        case .threeMonths:
            return monthlyAverages.suffix(3).map { $0 }
        case .sixMonths:
            return monthlyAverages
        }
    }
    
    var averageStepsData: Int {
        guard !displayData.isEmpty else { return 0 }
        let totalSteps = displayData.reduce(into: 0) { total, data in
            total += data.average
        }
        return Int(round(totalSteps / Double(displayData.count)))
    }
    
    // To determine which one of (clinician comments, supporter comments, contextual factors) is currently selected
    func isInsightTypeSelected(_ type: AdditionalInsightType) -> Bool {
        return selectedAdditionalInsightType == type
    }
    
    // Below is for when the user clicks on the step count trend card
    func calculateThreeMonthTrends() -> (firstThreeMonths: Double, secondThreeMonths: Double) {
        let allMonths = monthlyAverages
        
        // Re-use what I already generated then split into 2
        let firstThreeMonths = Array(allMonths.prefix(3))
        let secondThreeMonths = Array(allMonths.suffix(3))
        
        // Calculate averages
        let firstPeriodAverage = firstThreeMonths.reduce(0.0) { $0 + $1.average } / 3.0
        let secondPeriodAverage = secondThreeMonths.reduce(0.0) { $0 + $1.average } / 3.0
        
        return (firstPeriodAverage, secondPeriodAverage)
    }

    // Add this to help determine trend direction
    func getTrendDescription() -> String {
        let (firstPeriod, secondPeriod) = calculateThreeMonthTrends()
        
        if secondPeriod > firstPeriod {
            return "Increasing since the last 3 months."
        } else if secondPeriod < firstPeriod {
            return "Decreasing since the last 3 months."
        } else {
            return "Maintaining over the last 6 months."
        }
    }
    
    
    
}
