//
//  MyReflectionsHelpButton.swift
//  Ripple
//
//  Created by Ashley Zhang on 14/4/2025.
//

import SwiftUI

struct MyReflectionsHelpButton: View {
    @Binding var showingHelpInfo: Bool
    let activitiesViewModel: ActivityDataViewModel
    let emotionsViewModel: EmotionDataViewModel
    
    var body: some View {
        Button(action: { showingHelpInfo = true }) {
            HStack(spacing: 16) {
                Image(systemName: "questionmark.circle")
                    .font(.title)
                Text("Help")
                    .font(.headline)
            }
            .foregroundColor(.black)
        }
        .frame(width: 150, height: 60)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.grayColour)
        .addBorder(Color.clear, width: 1, cornerRadius: 20)
        .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
        .sheet(isPresented: $showingHelpInfo) {
            MyReflectionsHelpModal(
                isPresented: $showingHelpInfo,
                activitiesViewModel: activitiesViewModel,
                emotionsViewModel: emotionsViewModel
            )
        }
    }
}
