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
            
            LogActivities()
            
            LogEmotions()
            
            VStack(spacing: 8) {
                Button("Log") {
                    print("Button Clicked")
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
