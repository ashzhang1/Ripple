//
//  CalendarMonth.swift
//  Ripple
//
//  Created by Ashley Zhang on 7/1/2025.
//

import SwiftUI

struct CalendarMonth: View {
    let month: String
    let weekdays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    
    var body: some View {
        ZStack {
            // Box background
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.grayColour)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(month)
                    .font(.headlineMedium)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                
                VStack(spacing: 4) {
                    // Days of the week - now using the same grid structure as boxes
                    HStack(spacing: 2) {
                        ForEach(weekdays, id: \.self) { day in
                            Text(day)
                                .font(.bodyCustom)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    // Calendar grid
                    VStack(spacing: 2) {
                        ForEach(0..<6) { _ in
                            HStack(spacing: 4) {
                                ForEach(0..<7) { _ in
                                    Rectangle()
                                        .fill(Color.blue)
                                        .aspectRatio(1.0, contentMode: .fit)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
            }
        }
        .frame(width: 275, height: 275)
    }
}
