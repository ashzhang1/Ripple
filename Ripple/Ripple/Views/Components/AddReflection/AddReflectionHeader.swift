//
//  AddReflectionHeader.swift
//  Ripple
//
//  Created by Ashley Zhang on 4/4/2025.
//

import SwiftUI

struct AddReflectionHeader: View {
    @State private var showingHelpInfo = false
    
    var body: some View {
        HStack {
            Text("Add New Reflection")
                .font(.title)
            
            Spacer()
            
            TrendsHelpButton(showingHelpInfo: $showingHelpInfo)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
