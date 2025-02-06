//
//  MyReflectionModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/2/2025.
//

import SwiftUI

struct MyReflectionModal: View {
    @Environment(\.dismiss) private var dismiss
    let reflection: MonthlyReflectionDataEntry
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                // Header
                VStack {
                    HStack {
                        Text("\(reflection.fullMonthName) Reflection")
                            .font(.titleMedium)
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            VStack {
                                Image(systemName: "pip.exit")
                                    .font(.title)
                                    .foregroundColor(Color.redColour)
                                Text("Exit")
                                    .font(.bodyCustomMedium)
                                    .foregroundColor(Color.redColour)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.grayColour)
                
                
                // Only show date if it exists
                if let date = reflection.recordedDate {
                    (Text("Recorded on: ")
                        .font(.subheadlineMedium)
                        .foregroundColor(Color.black)
                        +
                     Text(dateFormatter.string(from: date)))
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .padding()
                }
                
                
                VStack(alignment: .leading, spacing: 24) {
                    if let reflectionQuestion = reflection.reflectionQuestion {
                        Text(reflectionQuestion)
                            .font(.subheadline)
                    }
                    
                    
                    Text("Your Response:")
                        .foregroundColor(.redColour)
                        .font(.subheadlineMedium)
                    
                    
                    if let reflectionResponse = reflection.reflectionResponse {
                        Text(reflectionResponse)
                            .font(.subheadline)
                    }
                }
                .padding() // Internal padding
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color.grayColour
                        .cornerRadius(8)
                )
                .padding(.horizontal, 24) // External padding
                
                
            }
        }
    }
    
}
