//
//  CalendarHeader.swift
//  Ripple
//
//  Created by Ashley Zhang on 11/1/2025.
//

import SwiftUI

struct CalendarHeader: View {
    @Binding var showDates: Bool
    
    var body: some View {
        HStack {
            Text("Calendar")
                .font(.display)
            
            Spacer()
            
            VStack {
                Text("Show Dates")
                    .font(.headline)
                HStack {
                    Text("Off")
                        .font(.subheadline)
                        .foregroundStyle(showDates ? .gray : .black)
                    Toggle("", isOn: $showDates)
                        .labelsHidden()
                    Text("On")
                        .font(.subheadline)
                        .foregroundStyle(showDates ? .black : .gray)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
