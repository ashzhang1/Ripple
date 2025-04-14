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
    @StateObject private var activitiesViewModel: ActivityDataViewModel
    @StateObject private var emotionsViewModel: EmotionDataViewModel
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        _monthlyReflectionsViewModel = StateObject(wrappedValue: MonthlyReflectionDataViewModel(viewContext: viewContext))
        _activitiesViewModel = StateObject(wrappedValue: ActivityDataViewModel(viewContext: viewContext))
        _emotionsViewModel = StateObject(wrappedValue: EmotionDataViewModel(viewContext: viewContext))
        self.viewContext = viewContext
    }
    
    
    var body: some View {
        
        VStack {
            MyReflectionsHeader(
                activitiesViewModel: activitiesViewModel,
                emotionsViewModel: emotionsViewModel
            )
            
            MyReflectionsGrid(
                reflections: monthlyReflectionsViewModel.monthlyReflectionData,
                activitiesViewModel: activitiesViewModel,
                emotionsViewModel: emotionsViewModel
            )
        }
        .ignoresSafeArea(.container, edges: .top)
        .onAppear {
            // Reload data when view appears
            Task {
               activitiesViewModel.loadActivityData()
               emotionsViewModel.loadEmotionData()
            }
        }
        
        
    }
}
