//
//  CommentModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 21/4/2025.
//

import SwiftUI

struct CommentModal: View {
    @Environment(\.dismiss) private var dismiss
    let date: Date
    let authorName: String
    let authorType: String
    let authorRelation: String?
    let comment: String
    
    private var daysPast: Int {
        let calendar = Calendar.current
        
        // Calculating it from Dec 1 bc synthetic data is from June 1 to Nov 30
        // So treat Dec 1 as current day
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 1))!
        
        // Calculate difference in days
        let days = calendar.dateComponents([.day], from: startDate, to: date).day ?? 0
        
        return abs(days)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    VStack {
                        HStack {
                            Text("Comment From \(authorName)")
                                .font(.headlineMedium)
                                .foregroundStyle(Color.redColour)
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
                    
                    // Days ago
                    Text("Posted \(daysPast)d ago")
                        .font(.headline)
                    
                    // Full comment text
                    Text(comment)
                        .font(.headlineMedium)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
