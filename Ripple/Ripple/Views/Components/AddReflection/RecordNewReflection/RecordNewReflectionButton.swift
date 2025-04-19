//
//  RecordNewReflectionButton.swift
//  Ripple
//
//  Created by Ashley Zhang on 19/4/2025.
//

import SwiftUI

struct RecordNewReflectionButton: View {
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text("Click to Record Response")
                .font(.subheadlineMedium)
                .frame(width: 100)
                .multilineTextAlignment(.center)
            
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: "mic.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

