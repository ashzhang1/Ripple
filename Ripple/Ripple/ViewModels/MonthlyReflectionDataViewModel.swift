//
//  MonthlyReflectionDataViewModel.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/2/2025.
//

import Foundation
import CoreData

class MonthlyReflectionDataViewModel: ObservableObject {
    @Published private(set) var monthlyReflectionData: [MonthlyReflectionDataEntry] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Task {
            await loadMonthlyReflectionData()
        }
    }
    
    @MainActor
    private func loadMonthlyReflectionData() {
        isLoading = true
        
        do {
            let request = NSFetchRequest<MonthlyReflectionData>(entityName: "MonthlyReflectionData")
            
            // Sort by month instead of recordedDate since some dates might be nil
            request.sortDescriptors = [NSSortDescriptor(keyPath: \MonthlyReflectionData.reflectionMonth, ascending: true)]
            
            let results = try viewContext.fetch(request)
            
            self.monthlyReflectionData = results.compactMap { coreDataItem in
                guard let id = coreDataItem.id else { return nil }
                
                // We only need to guard for id since it's the only required field
                return MonthlyReflectionDataEntry(
                    id: id,
                    recordedDate: coreDataItem.recordedDate,  // Pass through as optional
                    reflectionMonth: coreDataItem.reflectionMonth,
                    reflectionQuestion: coreDataItem.reflectionQuestion,
                    reflectionResponse: coreDataItem.reflectionResponse
                )
            }
            
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
