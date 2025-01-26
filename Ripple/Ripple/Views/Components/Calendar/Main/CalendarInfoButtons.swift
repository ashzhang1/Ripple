//
//  CalendarInfoButtons.swift
//  Ripple
//
//  Created by Ashley Zhang on 11/1/2025.
//

import SwiftUI

struct CalendarInfoButtons: View {
    @Binding var showingStepInfo: Bool
    @Binding var showingHelpInfo: Bool
    
    var body: some View {
        HStack(spacing: 70) {
            StepInfoButton(showingStepInfo: $showingStepInfo)
            HelpButton(showingHelpInfo: $showingHelpInfo)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct StepInfoButton: View {
    @Binding var showingStepInfo: Bool
    
    var body: some View {
        Button(action: { showingStepInfo = true }) {
            HStack(spacing: 16) {
                Image(systemName: "shoeprints.fill")
                    .font(.title)
                Text("About Step Count")
                    .font(.headline)
            }
            .foregroundColor(.black)
        }
        .frame(width: 300, height: 60)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.grayColour)
        .addBorder(Color.clear, width: 1, cornerRadius: 20)
        .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
        .sheet(isPresented: $showingStepInfo) {
            AboutStepCountModal(isPresented: $showingStepInfo)
        }
    }
}

struct HelpButton: View {
    @Binding var showingHelpInfo: Bool
    
    
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
            CalendarHelpModal(isPresented: $showingHelpInfo)
        }
    }
}
