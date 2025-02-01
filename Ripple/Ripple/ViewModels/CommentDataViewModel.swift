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
    }
    
    
}
