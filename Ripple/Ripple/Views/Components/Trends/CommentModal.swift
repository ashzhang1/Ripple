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
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(authorName)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            HStack {
                                // Only show relation if it is available (i.e, only for supporters)
                                if let relation = authorRelation {
                                    Text("\(relation)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Text("• \(daysPast)d ago")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // Full comment text
                    Text(comment)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                            .font(.title3)
                    }
                }
            }
        }
    }
}
