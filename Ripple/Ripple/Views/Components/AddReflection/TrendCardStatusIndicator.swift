//
//  TrendCardStatusIndicator.swift
//  Ripple
//
//  Created by Ashley Zhang on 6/4/2025.
//

import SwiftUI

struct TrendCardStatusIndicator: View {
    let isCompleted: Bool
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Rectangle()
                    .strokeBorder(Color.gray, lineWidth: 1)
                    .frame(width: 24, height: 24)
                    .background(Color.white)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            
            Text(isCompleted ? "Completed" : "Not Yet Completed")
                .foregroundColor(isCompleted ? .blue : .orange)
        }
    }
}
