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
    private func loadActivityData() {
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
        
        
        print(Array(topActivities))
        
        return Array(topActivities)
    }
    
}
