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
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 1))!
        
        // Calculate difference in days
        let days = calendar.dateComponents([.day], from: startDate, to: date).day ?? 0
        
        return abs(days)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(authorName)
                
                if let relation = authorRelation {
                    Text("(\(relation))")
                } else {
                    Text("")
                }
                
                Spacer()
                
                Text("\(daysPast)d ago")
            }
            
            Text(comment)
                .font(.bodyCustom)
                .multilineTextAlignment(.leading)
            
            CommentBoxCheckBox(isRead: false)
        }
        .frame(width: 350, height: 180)
    }
}


struct CommentBoxCheckBox: View {
    @State var isRead: Bool
    
    
    var body: some View {
        HStack(spacing: 8) { // Reduced spacing to match image
            // Custom square checkbox
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
                .background(
                    isRead ? Color.blue : Color.white
                )
                .frame(width: 24, height: 24)
                .overlay {
                    if isRead {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            
            // Text that changes based on state
            Text(isRead ? "Read" : "Not Read")
                .foregroundColor(.orange) // Using orange to match image
                .font(.system(size: 16))
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.2)) {
                isRead.toggle()
            }
        }
    }
}
