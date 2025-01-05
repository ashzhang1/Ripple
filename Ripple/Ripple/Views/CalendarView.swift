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
        
        VStack(spacing: 16) {
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
            
            HStack {
                CalendarLegend()
                Spacer()
            }
            
            HStack(spacing: 70) {
                Button(action: {
                    // TODO
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "shoeprints.fill")
                            .font(.title)
                        
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
                        Image(systemName: "questionmark.circle")
                            .font(.title)
                        
                        Text("Help")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                }
                .padding(.horizontal, 44)
                .padding(.vertical, 20)
                .background(Color(hue: 0, saturation: 0, brightness: 0.85, opacity: 1.0))
                .addBorder(Color.clear, width: 1, cornerRadius: 8)
                
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .ignoresSafeArea(edges: .top)
        
        
    }
}

#Preview("11-inch iPad Pro", traits: .landscapeRight) {
    CalendarView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
