//
//  ActivityDataViewModel.swift
//  Ripple
//
//  Created by Ashley Zhang on 20/1/2025.
//

import Foundation
import CoreData

class ActivityDataViewModel: ObservableObject {
    @Published private(set) var activityData: [ActivityDataEntry] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Task {
            await loadActivityData()
        }
    }

    @MainActor
    public func loadActivityData() {
        isLoading = true
        
        do {
            let request = NSFetchRequest<ActivityData>(entityName: "ActivityData")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \ActivityData.date, ascending: true)]
            
            let results = try viewContext.fetch(request)
            self.activityData = results.compactMap { coreDataItem in
                guard let id = coreDataItem.id,
                      let date = coreDataItem.date,
                      let activityType = coreDataItem.activityType else { return nil }
                
                return ActivityDataEntry(
                    id: id,
                    date: date,
                    activityType: activityType
                )
            }
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    // MARK: - Helper Methods
    func getTopActivitiesForMonth(_ date: Date) -> [(activityType: String, count: Int)] {
        // Filter activities for the given month
        let monthActivities = activityData.filter { activity in
            Calendar.current.isDate(activity.date, equalTo: date, toGranularity: .month)
        }
        
        // Group by activity type and count occurrences
        let activityCounts = Dictionary(grouping: monthActivities) { $0.activityType }
            .mapValues { $0.count }
        
        // Only return the top 3
        let topActivities = activityCounts.sorted { $0.value > $1.value }
            .prefix(3)
            .map { (activityType: $0.key, count: $0.value) }
        
        
        return Array(topActivities)
    }
    
    
    // This gets the top activities between two given dates
    func getTopActivitiesForPeriod(from startDate: Date, to endDate: Date) -> [(activityType: String, count: Int)] {
        
        // Filter by the dates first
        let activities = activityData.filter { activity in
            return activity.date >= startDate && activity.date <= endDate
        }
        
        // Group by activity type and count occurrences
        let activityCounts = Dictionary(grouping: activities) { $0.activityType }
            .mapValues { $0.count }
        
        // Only return the top 3
        let topActivities = activityCounts.sorted { $0.value > $1.value }
            .prefix(3)
            .map { (activityType: $0.key, count: $0.value) }
        
        
        return Array(topActivities)
        
        
    }
    
    // This is for saving the newly logged activities in add new reflection page
    @MainActor
    func saveActivities(_ selectedActivities: Set<ActivityIcons>, forDate date: Date = Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 30))!) {
        // Begin transaction
        do {
            print("Attempting to save \(selectedActivities.count) activities for date \(date)")
            
            // Create a new Core Data entry for each selected activity
            for activity in selectedActivities {
                let newActivityData = ActivityData(context: viewContext)
                newActivityData.id = UUID()
                newActivityData.date = date
                newActivityData.activityType = activity.rawValue  // Use rawValue to ensure consistency
                
                // Add to our published property so UI can update immediately
                self.activityData.append(ActivityDataEntry(
                    id: newActivityData.id!,
                    date: date,
                    activityType: activity.rawValue
                ))
                
                print("Added activity: \(activity.rawValue) for date \(date)")
            }
            
            // Save the context
            try viewContext.save()
            print("Successfully saved activities to Core Data")
            
            // Reload data to ensure consistency
            loadActivityData()
            
        } catch {
            // Handle any errors
            self.error = error
            print("Error saving activities: \(error.localizedDescription)")
        }
    }
    
    
}
