//
//  MyReflectionsGrid.swift
//  Ripple
//
//  Created by Ashley Zhang on 4/2/2025.
//

import SwiftUI

struct MyReflectionsGrid: View {
    
    private let months = [
            "Jan", "Feb", "Mar",
            "Apr", "May", "Jun",
            "Jul", "Aug", "Sep",
            "Oct", "Nov", "Dec"
    ]
    
    // Define grid layout
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("2024")
                .font(.titleSemiBold)
            
            Text("Tap on a month to explore your reflections from that time.")
                .font(.subheadline)
                .foregroundStyle(Color.fontGrayColour)
            
            
            // Add actual grid below
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(months, id: \.self) { month in
                    MyReflectionGridBox(month: month)
                }
            }
            .padding()
        }
        .frame(maxWidth: 700)
    }
}
