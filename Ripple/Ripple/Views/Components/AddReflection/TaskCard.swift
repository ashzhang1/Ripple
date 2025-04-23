//
//  TaskCard.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/4/2025.
//

import SwiftUI

struct TaskCard<Destination: View>: View {
    let title: String
    let dueDate: String?
    let buttonLabel: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.titleMedium)
                
                if let dueDate = dueDate {
                    Text("Due \(dueDate)")
                        .font(.headline)
                        .foregroundStyle(Color.fontGrayColour)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    TrendCardStatusIndicator(isCompleted: true)
                    Spacer()
                    Text(buttonLabel)
                        .font(.headlineMedium)
                        .underline()
                }
            }
            .padding(24)
            .frame(width: 500, height: 260)
            .background(Color.grayColour)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
        }
        .buttonStyle(PlainButtonStyle())
        
    }
    
}
