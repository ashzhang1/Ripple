//
//  ContextualFactorsIcon.swift
//  Ripple
//
//  Created by Ashley Zhang on 17/1/2025.
//

import SwiftUI

struct ContextualFactorsIcon: View {
    let icon: String
    let title: String
    let quantity: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.darkGrayColour)
                    .frame(width: 48, height: 48)
                
                Text(icon)
                    .font(.title)
                
                
            }
            
            Text(title)
                .font(.bodyCustom)
            Text("x\(quantity)")
                .font(.bodyCustom)
        }
    
    }
}
