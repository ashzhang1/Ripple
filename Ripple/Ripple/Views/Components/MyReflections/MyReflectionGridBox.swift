//
//  MyReflectionGridBox.swift
//  Ripple
//
//  Created by Ashley Zhang on 4/2/2025.
//

import SwiftUI

struct MyReflectionGridBox: View {
    let month: String
    
    
    var body: some View {
        
        
        Button(action: {
            
        }) {
            VStack(alignment: .leading, spacing: 4) {
                Text(month)
                    .font(.title)
                    .foregroundStyle(.black)
                
                Spacer()
                
                HStack {
                    Text("View Reflection")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "arrowshape.forward.circle")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(12)
        .background(Color.grayColour)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
        .frame(width: 168, height: 140)
        
    }
}
