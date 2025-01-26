//
//  TrendsViewHeader.swift
//  Ripple
//
//  Created by Ashley Zhang on 25/1/2025.
//

import SwiftUI

struct TrendsHeader: View {
    @State private var showingHelpInfo = false
    
    var body: some View {
        HStack {
            Text("Trends")
                .font(.display)
            
            Spacer()
            
            TrendsHelpButton(showingHelpInfo: $showingHelpInfo)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
