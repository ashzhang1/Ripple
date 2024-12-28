//
//  CalendarView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var showDates = true
    
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                Text("Calendar")
                    .font(.display)
                
                Text("Step Count")
                    .font(.title)
                    .foregroundColor(.grayColor)
                
            }
            
            Button(action: {
                // TODO
            }) {
                HStack(spacing: 16) {
                    Image(systemName: "shoeprints.fill")
                        .font(.headline)
                    
                    Text("About Step Count")
                        .font(.headline)
                }
                .foregroundColor(.black)
            }
            .padding(.horizontal, 52)
            .padding(.vertical, 20)
            .background(Color(hue: 0, saturation: 0, brightness: 0.85, opacity: 1.0))
            .addBorder(Color.clear, width: 1, cornerRadius: 8)
            
            Button(action: {
                // TODO
            }) {
                HStack(spacing: 16) {
                    Image(systemName: "questionmark.circle.dashed")
                        .font(.headline)
                    
                    Text("Help")
                        .font(.headline)
                }
                .foregroundColor(.black)
            }
            .padding(.horizontal, 44)
            .padding(.vertical, 20)
            .background(Color(hue: 0, saturation: 0, brightness: 0.85, opacity: 1.0))
            .addBorder(Color.clear, width: 1, cornerRadius: 8)
            
            VStack {
                Text("Show Dates")
                HStack {
                    Text("Off")
                        .foregroundStyle(showDates ? .gray : .black)
                    Toggle("", isOn: $showDates)
                        .labelsHidden()
                    Text("On")
                        .foregroundStyle(showDates ? .black : .gray)
                }
            }
            
        }
    }
}

#Preview("11-inch iPad Pro", traits: .landscapeLeft) {
    CalendarView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
