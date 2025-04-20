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
    @Published var isSaving = false
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Task {
            await loadMonthlyReflectionData()
        }
    }
    
    @MainActor
    public func loadMonthlyReflectionData() {
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
    
    @MainActor
    func saveReflection(reflectionText: String, question: String = "What stood out to you this November?") async -> Bool {
        isSaving = true
        
        // Hard-coded date for November 2024
        let novemberDate = Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 30))!
        
        // Check if there's an existing reflection for November
        let fetchRequest = NSFetchRequest<MonthlyReflectionData>(entityName: "MonthlyReflectionData")
        fetchRequest.predicate = NSPredicate(format: "reflectionMonth == %d", 11) // 11 represents November
        
        do {
            // Try to find an existing entry
            let existingEntries = try viewContext.fetch(fetchRequest)
            
            let reflectionData: MonthlyReflectionData
            
            if let existingEntry = existingEntries.first {
                // Update existing entry
                reflectionData = existingEntry
            } else {
                // Create a new entry
                reflectionData = MonthlyReflectionData(context: viewContext)
                reflectionData.id = UUID()
                reflectionData.reflectionMonth = 11 // November
            }
            
            // Update the reflection data
            reflectionData.recordedDate = novemberDate
            reflectionData.reflectionQuestion = question
            reflectionData.reflectionResponse = reflectionText
            
            // Save the context
            try viewContext.save()
            
            // Reload the data
            loadMonthlyReflectionData()
            isSaving = false
            return true
            
        } catch {
            self.error = error
            print("Failed to save reflection: \(error.localizedDescription)")
            isSaving = false
            return false
        }
    }
    
    
}
