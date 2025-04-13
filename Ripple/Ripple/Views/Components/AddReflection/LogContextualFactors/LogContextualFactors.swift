//
//  LogContextualFactors.swift
//  Ripple
//
//  Created by Ashley Zhang on 12/4/2025.
//

import SwiftUI
import CoreData

struct LogContextualFactors: View {
    let viewContext: NSManagedObjectContext
    @StateObject private var activitiesViewModel: ActivityDataViewModel
    @StateObject private var emotionsViewModel: EmotionDataViewModel
    @State private var selectedActivities = Set<ActivityIcons>()
    @State private var selectedEmotions = Set<EmotionIcons>()
    @Environment(\.dismiss) private var dismiss
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        _activitiesViewModel = StateObject(wrappedValue: ActivityDataViewModel(viewContext: viewContext))
        _emotionsViewModel = StateObject(wrappedValue: EmotionDataViewModel(viewContext: viewContext))
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            AddReflectionHeader()
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                        Text("Back")
                            .font(.headline)
                    }
                }
                .foregroundColor(.blue)
                .padding(.leading, 16)
                
                Spacer()
            }
            .padding(.top, 8)
            
            LogActivities(selectedActivities: $selectedActivities)
            LogEmotions(selectedEmotions: $selectedEmotions)
            
            VStack(spacing: 8) {
                Button("Log") {
                    activitiesViewModel.saveActivities(selectedActivities)
                    emotionsViewModel.saveEmotions(selectedEmotions)
                    print("Selected activities: \(selectedActivities.map { $0.label }.joined(separator: ", "))")
                    print("Selected emotions: \(selectedEmotions.map { $0.label }.joined(separator: ", "))")
                    dismiss()
                }
                .frame(width: 100, height: 50)
                .font(.headlineSemiBold)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
                
                
                Text("Click Log Once Finished")
                    .font(.headlineMedium)
            }
            
            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }
}
