//
//  LogContextualFactors.swift
//  Ripple
//
//  Created by Ashley Zhang on 12/4/2025.
//

import SwiftUI

struct LogContextualFactors: View {
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack(spacing: 0) { // Set spacing to 0 to control it manually
            AddReflectionHeader()
            
            // Back button directly in the VStack
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
            .padding(.top, 8) // Reduced from 32 to 8
            
            LogActivities()
            
            LogEmotions()
            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }
}
