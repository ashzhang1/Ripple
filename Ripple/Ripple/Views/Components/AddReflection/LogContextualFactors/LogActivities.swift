//
//  LogActivities.swift
//  Ripple
//
//  Created by Ashley Zhang on 12/4/2025.
//

import SwiftUI

struct LogActivities: View {
    @Binding var selectedActivities: Set<ActivityIcons>
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Select all the activities you did today.")
                .font(.headlineMedium)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(ActivityIcons.allCases, id: \.self) { activity in
                    ContextualFactorsItem(
                        item: activity,
                        isSelected: selectedActivities.contains(activity),
                        action: {
                            toggleSelection(for: activity)
                        }
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: 600)
        }
        .padding()
    }
    
    private func toggleSelection(for activity: ActivityIcons) {
        if selectedActivities.contains(activity) {
            selectedActivities.remove(activity)
        } else {
            selectedActivities.insert(activity)
        }
    }
}
