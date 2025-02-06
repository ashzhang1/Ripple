//
//  MyReflectionsView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI
import CoreData

struct MyReflectionsView: View {
    @StateObject private var monthlyReflectionsViewModel: MonthlyReflectionDataViewModel
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        _monthlyReflectionsViewModel = StateObject(wrappedValue: MonthlyReflectionDataViewModel(viewContext: viewContext))
        self.viewContext = viewContext
    }
    
    
    var body: some View {
        
        VStack {
            MyReflectionsHeader()
            
            MyReflectionsGrid(reflections: monthlyReflectionsViewModel.monthlyReflectionData)
        }
        .ignoresSafeArea(.container, edges: .top)
        
        
    }
}
