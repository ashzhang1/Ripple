//
//  CommentBox.swift
//  Ripple
//
//  Created by Ashley Zhang on 2/2/2025.
//

import SwiftUI

struct CommentBox: View {
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
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(authorName)
                    .font(.subheadlineMedium)
                
                // Only show relation if it is available (i.e, only for supporters)
                if let relation = authorRelation {
                    Text("(\(relation))")
                        .font(.subheadlineMedium)
                        .foregroundColor(.gray)
                } else {
                    Text("")
                }
                
                Spacer()
                
                Text("\(daysPast)d ago")
                    .font(.subheadlineMedium)
                    .foregroundColor(.gray)
            }
            
            Text(comment)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .frame(height: 85)
            
            CommentBoxCheckBox(isRead: false)
        }
        .padding()
        .background(Color.grayColour)
        .cornerRadius(8)
        .frame(width: 380, height: 200)
    }
}


struct CommentBoxCheckBox: View {
    @State var isRead: Bool
    
    
    var body: some View {
        HStack(spacing: 8) {
            
            // Checkbox
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
                .background(
                    isRead ? Color.green : Color.white
                )
                .frame(width: 24, height: 24)
                .overlay {
                    if isRead {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            
            // Change to read/not read on tap
            Text(isRead ? "Read" : "Not Read")
                .foregroundColor(isRead ? Color.green : Color.orange)
                .font(.subheadline)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.2)) {
                isRead.toggle()
            }
        }
    }
}
