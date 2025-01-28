//
//  ContextualFactorsPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/1/2025.
//

import SwiftUI

struct ContextualFactorsPanel: View {
    var body: some View {
        
        VStack {
            HStack(spacing: 44) {
                
                Button(action: {
                    //TODO
                }) {
                    Text("Clinician Comments")
                        .font(.subheadlineSemiBold)
                }
                .frame(width: 275, height: 44)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.grayColour)
                .addBorder(Color.clear, width: 1, cornerRadius: 20)
                .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
                
                Button(action: {
                    //TODO
                }) {
                    Text("Supporter Comments")
                        .font(.subheadlineSemiBold)
                }
                .frame(width: 275, height: 44)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.grayColour)
                .addBorder(Color.clear, width: 1, cornerRadius: 20)
                .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
                
                
                Button(action: {
                    //TODO
                }) {
                    Text("Contextual Factors")
                        .font(.subheadlineSemiBold)
                }
                .frame(width: 250, height: 44)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.grayColour)
                .addBorder(Color.clear, width: 1, cornerRadius: 20)
                .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
                
            }
        }
    }
}
