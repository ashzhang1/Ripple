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
            
            // This is the actual box
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.grayColour)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
            
            // This is the content
            VStack(alignment: .leading, spacing: 12) {
                
                Text(month)
                    .font(.headlineMedium)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                // Days of the week
                HStack(spacing: 0) {
                    ForEach(weekdays, id: \.self) { day in
                        Text(day)
                            .font(.bodyCustom)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .frame(width: 275, height: 275)

    }
}

//#Preview {
//    CalendarMonth()
//}
