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
    private func loadEmotionData() {
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
}
