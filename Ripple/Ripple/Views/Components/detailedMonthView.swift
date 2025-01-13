//
//  detailedMonthView.swift
//  Ripple
//
//  Created by Ashley Zhang on 13/1/2025.
//

import SwiftUI

struct detailedMonthView: View {
    @Environment(\.dismiss) private var dismiss // We apparently need this to get access to the dismiss function
    let date: Date
        
    private var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            Text("Step Count Details for \(monthName)")
                .font(.title)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss() // This allows us to go back to the previous page
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Calendar")
                            .font(.title2)
                    }
                }
            }
        }

    }
}
