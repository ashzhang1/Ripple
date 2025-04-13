//
//  EmotionDataViewModel.swift
//  Ripple
//
//  Created by Ashley Zhang on 21/1/2025.
//

import Foundation
import CoreData

class EmotionDataViewModel: ObservableObject {
    @Published private(set) var emotionData: [EmotionDataEntry] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Task {
            await loadEmotionData()
        }
    }

    @MainActor
    public func loadEmotionData() {
        isLoading = true
        
        do {
            let request = NSFetchRequest<EmotionData>(entityName: "EmotionData")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \EmotionData.date, ascending: true)]
            
            let results = try viewContext.fetch(request)
            self.emotionData = results.compactMap { coreDataItem in
                guard let id = coreDataItem.id,
                      let date = coreDataItem.date,
                      let emotionType = coreDataItem.emotionType else { return nil }
                
                return EmotionDataEntry(
                    id: id,
                    date: date,
                    emotionType: emotionType
                )
            }
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    // MARK: - Helper Methods
    
    func getTopEmotionsForMonth(_ date: Date) -> [(emotionType: String, count: Int)] {
        
        // Filter emotions for the given month
        let monthEmotions = emotionData.filter { activity in
            Calendar.current.isDate(activity.date, equalTo: date, toGranularity: .month)
        }
        
        // Group by emotion type and count occurrences
        let emotionCounts = Dictionary(grouping: monthEmotions) { $0.emotionType }
            .mapValues { $0.count }
        
        // Only return the top 3
        let topEmotions = emotionCounts.sorted { $0.value > $1.value }
            .prefix(3)
            .map { (emotionType: $0.key, count: $0.value) }
    
        
        return Array(topEmotions)
    }
    
    // This gets the top emotions between two given dates
    func getTopEmotionsForPeriod(from startDate: Date, to endDate: Date) -> [(emotionType: String, count: Int)] {
        
        // Filter by the dates first
        let emotions = emotionData.filter { emotion in
            return emotion.date >= startDate && emotion.date <= endDate
        }
        
        // Group by emotion type and count occurrences
        let emotionCounts = Dictionary(grouping: emotions) { $0.emotionType }
            .mapValues { $0.count }
        
        // Only return the top 3
        let topEmotions = emotionCounts.sorted { $0.value > $1.value }
            .prefix(3)
            .map { (emotionType: $0.key, count: $0.value) }
        
        
        return Array(topEmotions)
        
    }
    
    // This is for saving the newly logged emotions in add new reflection page
    @MainActor
    func saveEmotions(_ selectedEmotions: Set<EmotionIcons>, forDate date: Date = Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 30))!) {
        // Begin transaction
        do {
            print("Attempting to save \(selectedEmotions.count) emotions for date \(date)")
            
            // Create a new Core Data entry for each selected emotion
            for emotion in selectedEmotions {
                let newEmotionData = EmotionData(context: viewContext)
                newEmotionData.id = UUID()
                newEmotionData.date = date
                newEmotionData.emotionType = emotion.rawValue  // Use rawValue to ensure consistency
                
                // Add to our published property so UI can update immediately
                self.emotionData.append(EmotionDataEntry(
                    id: newEmotionData.id!,
                    date: date,
                    emotionType: emotion.rawValue
                ))
                
                print("Added emotion: \(emotion.rawValue) for date \(date)")
            }
            
            // Save the context
            try viewContext.save()
            print("Successfully saved emotions to Core Data")
            
            // Reload data to ensure consistency
            loadEmotionData()
            
        } catch {
            // Handle any errors
            self.error = error
            print("Error saving emotions: \(error.localizedDescription)")
        }
    }
}
