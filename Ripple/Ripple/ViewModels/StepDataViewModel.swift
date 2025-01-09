//
//  StepDataViewModel.swift
//  Ripple
//
//  Created by Ashley Zhang on 6/1/2025.
//

import CoreData
import SwiftUI

class StepDataViewModel: ObservableObject {
    
    struct GoalThresholds {
        static let goalCompleteDay: Int = 4000
        static let overHalfGoal: Int = 2001
        static let underHalfGoal: Int = 1999
        static let nonWearDay: Double = 4
    }
    
    @Published private(set) var displayMonths: [[Date]] = [] // computed property of the calendar month names
    @Published private(set) var stepData: [StepDataEntry] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Task {
            await loadStepData()
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
            updateDisplayMonths()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    // MARK: - Helper Methods
    
    func refreshStepCount() {
        Task {
            await loadStepData()
        }
    }
    
    //The below funcs are used for the calendar legend
    func getCompletedGoalDaysCount() -> Int {
        return stepData.filter { entry in
            entry.stepCount >= GoalThresholds.goalCompleteDay &&
            entry.wearTime >= GoalThresholds.nonWearDay
        }.count
    }
    
    func getNumOverHalfGoalDays() -> Int {
        return stepData.filter { entry in
            entry.stepCount >= GoalThresholds.overHalfGoal &&
            entry.stepCount < GoalThresholds.goalCompleteDay &&
            entry.wearTime >= GoalThresholds.nonWearDay
        }.count
    }
    
    func getNumUnderHalfGoalsDays() -> Int {
        return stepData.filter{ entry in
            entry.stepCount <= GoalThresholds.underHalfGoal &&
            entry.wearTime >= GoalThresholds.nonWearDay
        }.count
    }
    
    func getNumNonWearDays() -> Int {
        return stepData.filter { entry in
            entry.wearTime < GoalThresholds.nonWearDay
        }.count
    }
    
    
    //this gets all the months needed for the calendar view
    private func getUniqueMonths() -> [Date] {
        let calendar = Calendar.current
        let uniqueMonths = Set(stepData.compactMap { entry in
            calendar.startOfMonth(for: entry.date)
        })
        return Array(uniqueMonths).sorted()
    }
    
//    private func updateDisplayMonths() {
//        let months = getUniqueMonths().sorted()
//        
//        // Organize the months into rows (2x3 grid)
//        displayMonths = stride(from: 0, to: months.count, by: 3).map {
//            Array(months[$0..<min($0 + 3, months.count)])
//        }
//    }
    
    private func updateDisplayMonths() {
        let months = getUniqueMonths().sorted()
        
        // Organize the months into rows (2x3 grid)
        var result: [[Date]] = []
        var currentRow: [Date] = []
        
        for month in months {
            currentRow.append(month)
            if currentRow.count == 3 {
                result.append(currentRow)
                currentRow = []
            }
        }
        
        // Don't forget the last row if it's not complete
        if !currentRow.isEmpty {
            result.append(currentRow)
        }
        
        displayMonths = result
    }
    
    
    
    
    
}
