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
        
        // Create dictionaries to track steps and wear time data
        var weeklyStepData: [Date: [Int]] = [:]
        var weeklyWearTimeData: [Date: [Double]] = [:]
        
        let fourWeekData = stepData.filter { $0.date >= fourWeeksAgo }

        for entry in fourWeekData {
            
            // Get the start of the week for this entry
            if let weekStart = calendar.startOfWeek(for: entry.date) {
                weeklyStepData[weekStart, default: []].append(entry.stepCount)
                weeklyWearTimeData[weekStart, default: []].append(entry.wearTime)
            }
        }
        
        // This is needed for the label under each of the bars of the bar chart
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"

        weeklyAverages = weeklyStepData.map { (date, steps) in
            let averageSteps = Double(steps.reduce(0, +)) / Double(steps.count)
            
            // Get wear time data for the same week
            let wearTimes = weeklyWearTimeData[date, default: []]
            let averageWearTime = wearTimes.isEmpty ? 0.0 : wearTimes.reduce(0, +) / Double(wearTimes.count)
            
            // Calculate the end date --> 6 days because inclusive
            guard let endDate = Calendar.current.date(byAdding: .day, value: 6, to: date) else {
                return StepAverage(period: date, averageStepCount: averageSteps, averageWearTime: averageWearTime, label: "Invalid date")
            }
            
            // Label for the bar
            let startDateString = dateFormatter.string(from: date)
            let endDateString = dateFormatter.string(from: endDate)
            
            return StepAverage(
                period: date,
                averageStepCount: averageSteps,
                averageWearTime: averageWearTime,
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
        var monthlyStepData: [Date: [Int]] = [:]
        var monthlyWearTimeData: [Date: [Double]] = [:]
        
        // No need to filter for date range since we know we have 6 months
        for entry in stepData {
            if let monthStart = calendar.startOfMonth(for: entry.date) {
                monthlyStepData[monthStart, default: []].append(entry.stepCount)
                monthlyWearTimeData[monthStart, default: []].append(entry.wearTime)
            }
        }
        
        // Format month names
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM" // "Jan", "Feb", etc.
        
        monthlyAverages = monthlyStepData.map { (date, steps) in
            let averageSteps = Double(steps.reduce(0, +)) / Double(steps.count)
            
            // Get wear time data for the same month
            let wearTimes = monthlyWearTimeData[date, default: []]
            let averageWearTime = wearTimes.isEmpty ? 0.0 : wearTimes.reduce(0, +) / Double(wearTimes.count)
            
            return StepAverage(
                period: date,
                averageStepCount: averageSteps,
                averageWearTime: averageWearTime,
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
    
    // Averages the step data
    var averageStepsData: Int {
        guard !displayData.isEmpty else { return 0 }
        let totalSteps = displayData.reduce(into: 0.0) { total, data in
            total += data.averageStepCount
        }
        return Int(round(totalSteps / Double(displayData.count)))
    }
    
    // Averages the wear time data
    var averageWearTimeData: Double {
        guard !displayData.isEmpty else { return 0.0 }
        let totalWearTime = displayData.reduce(into: 0.0) { total, data in
            total += data.averageWearTime
        }
        return (totalWearTime / Double(displayData.count)).rounded()
    }
    
    // To determine which one of (clinician comments, supporter comments, contextual factors) is currently selected
    func isInsightTypeSelected(_ type: AdditionalInsightType) -> Bool {
        return selectedAdditionalInsightType == type
    }
    
    // Below is for when the user clicks on the step count trend card
    func calculateThreeMonthTrends() -> (stepCount: (first: Double, second: Double), wearTime: (first: Double, second: Double)) {
        let allMonths = monthlyAverages

        let firstThreeMonths = Array(allMonths.prefix(3))
        let secondThreeMonths = Array(allMonths.suffix(3))
        
        // Calculate step count averages
        let firstPeriodStepAverage = firstThreeMonths.reduce(0.0) { $0 + $1.averageStepCount } / 3.0
        let secondPeriodStepAverage = secondThreeMonths.reduce(0.0) { $0 + $1.averageStepCount } / 3.0
        
        // Calculate wear time averages
        let firstPeriodWearTimeAverage = firstThreeMonths.reduce(0.0) { $0 + $1.averageWearTime } / 3.0
        let secondPeriodWearTimeAverage = secondThreeMonths.reduce(0.0) { $0 + $1.averageWearTime } / 3.0
        
        return ((firstPeriodStepAverage, secondPeriodStepAverage),
                (firstPeriodWearTimeAverage, secondPeriodWearTimeAverage))
    }

    // TODO: Work in progress
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
