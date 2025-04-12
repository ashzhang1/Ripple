//
//  LogEmotions.swift
//  Ripple
//
//  Created by Ashley Zhang on 12/4/2025.
//

import SwiftUI

struct LogEmotions: View {
    @State private var selectedEmotions: Set<EmotionIcons> = []
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Select all the emotions you felt today.")
                .font(.headlineMedium)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(EmotionIcons.allCases, id: \.self) { emotion in
                    ContextualFactorsItem(
                        item: emotion,
                        isSelected: selectedEmotions.contains(emotion),
                        action: {
                            toggleSelection(for: emotion)
                        }
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: 600)
        }
        .padding()
    }
    
    private func toggleSelection(for emotion: EmotionIcons) {
        if selectedEmotions.contains(emotion) {
            selectedEmotions.remove(emotion)
        } else {
            selectedEmotions.insert(emotion)
        }
    }
}
