//
//  MyReflectionGridBox.swift
//  Ripple
//
//  Created by Ashley Zhang on 4/2/2025.
//

import SwiftUI

struct MyReflectionGridBox: View {
    let reflection: MonthlyReflectionDataEntry
    @ObservedObject var activitiesViewModel: ActivityDataViewModel
    @ObservedObject var emotionsViewModel: EmotionDataViewModel
    @State private var showingModal = false
    
    var body: some View {
        Button(action: {
            if (!reflection.isEmpty) {
                // Ensure data is loaded before showing the modal
                Task {
                    await MainActor.run {
                        activitiesViewModel.loadActivityData()
                        emotionsViewModel.loadEmotionData()
                    }
                    await MainActor.run {
                        showingModal = true
                    }
                }
            }
        }) {
            VStack(alignment: .leading, spacing: 8) {
                Text(reflection.shortMonthName)
                    .font(.title)
                    .foregroundStyle(reflection.isEmpty ? .gray : .black)

                
                HStack {
                    Text(reflection.isEmpty ? "No Reflection Recorded" : "View Reflection")
                        .font(.subheadline)
                        .foregroundStyle(reflection.isEmpty ? .gray : .black)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    if (!reflection.isEmpty) {
                        Image(systemName: "arrowshape.forward.circle")
                            .font(.headline)
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
        .padding(12)
        .background(reflection.isEmpty ? Color.darkGrayColour : Color.grayColour)
        .cornerRadius(8)
        .shadow(
            color: Color.black.opacity(!reflection.isEmpty ? 0.5 : 0),
            radius: 4,
            x: 0,
            y: 5
        )
        .frame(width: 168, height: 140)
        .sheet(isPresented: $showingModal) {
            Group {
                if reflection.monthAsDate != nil {
                    MyReflectionModal(
                        reflection: reflection,
                        activitiesViewModel: activitiesViewModel,
                        emotionsViewModel: emotionsViewModel
                    )
                }
            }
        }
    }
}
