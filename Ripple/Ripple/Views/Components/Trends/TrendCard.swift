//
//  TrendCard.swift
//  Ripple
//
//  Created by Ashley Zhang on 26/1/2025.
//

import SwiftUI

struct TrendCard: View {
    let isStepCounTrendCard: Bool
    let trendTitle: String
    let trendDescription: String
    
    private var titleColour: Color {
        isStepCounTrendCard ? .greenCardTitleColour : .purpleCardTitleColour
    }
    
    private var cardBackgroundColour: Color {
        isStepCounTrendCard ? .greenCardColour : .purpleCardColour
    }
    
    var body: some View {
        Button(action: {
            // Empty action for now
            // We'll add functionality later
        }) {
            ZStack {
                // Background with shadow
                RoundedRectangle(cornerRadius: 12)
                    .fill(cardBackgroundColour)
                    .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
                
                // Content container that takes full width
                HStack {
                    // Content aligned to leading edge
                    VStack(alignment: .leading, spacing: 12) {
                        Text(trendTitle)
                            .font(.subheadlineSemiBold)
                            .foregroundColor(titleColour)
                        Text(trendDescription)
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .frame(width: 300, height: 130)
        }
    }
}
