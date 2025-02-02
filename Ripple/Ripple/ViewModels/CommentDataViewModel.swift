//
//  CommentDataViewModel.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/2/2025.
//

import Foundation
import CoreData

class CommentDataViewModel: ObservableObject {
    @Published private(set) var clinicianCommentData: [CommentDataEntry] = []
    @Published private(set) var supporterCommentData: [CommentDataEntry] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        Task {
            await loadCommentData()
        }
    }
    
    @MainActor
    private func loadCommentData() {
        isLoading = true
        
        do {
            let request = NSFetchRequest<CommentData>(entityName: "CommentData")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \CommentData.date, ascending: true)]
            
            let results = try viewContext.fetch(request)
            
            for comment in results {
                guard let id = comment.id,
                      let date = comment.date,
                      let authorName = comment.authorName,
                      let authorType = comment.authorType,
                      let commentText = comment.comment else { continue }
                
                // authorRelation is now optional and handled separately
                let commentEntry = CommentDataEntry(
                    id: id,
                    date: date,
                    authorName: authorName,
                    authorType: authorType,
                    authorRelation: comment.authorRelation,  // This is now optional
                    comment: commentText
                )
                
                if let authorType = CommentAuthorTypes(rawValue: authorType) {
                    switch authorType {
                    case .clinician:
                        clinicianCommentData.append(commentEntry)
                    case .supporter:
                        supporterCommentData.append(commentEntry)
                    }
                }
            }
            
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
