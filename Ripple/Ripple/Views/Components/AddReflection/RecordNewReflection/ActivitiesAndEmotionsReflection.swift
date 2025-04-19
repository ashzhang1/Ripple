//
//  ActivitiesAndEmotionsReflection.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct ActivitiesAndEmotionsReflection: View {
    var body: some View {
            HStack(alignment: .top, spacing: 40) {
                // Activities column
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        Text("🍳")
                            .font(.subheadline)
                        Text("Cooking")
                            .font(.subheadline)
                    }
                    
                    HStack(spacing: 8) {
                        Text("🚶")
                            .font(.subheadline)
                        Text("Walking")
                            .font(.subheadline)
                    }
                    
                    HStack(spacing: 8) {
                        Text("🧹")
                            .font(.subheadline)
                        Text("Chores")
                            .font(.subheadline)
                    }
                }
                
                // Emotions column
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        Text("😊")
                            .font(.subheadline)
                        Text("Motivated")
                            .font(.subheadline)
                    }
                    
                    HStack(spacing: 8) {
                        Text("😀")
                            .font(.subheadline)
                        Text("Proud")
                            .font(.subheadline)
                    }
                    
                    HStack(spacing: 8) {
                        Text("😃")
                            .font(.subheadline)
                        Text("Happy")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.horizontal)
        }
}
