//
//  MyReflectionsHeader.swift
//  Ripple
//
//  Created by Ashley Zhang on 4/2/2025.
//

import SwiftUI

struct MyReflectionsHeader: View {
    @State private var showingHelpInfo = false
    
    
    var body: some View {
        HStack {
            Text("My Past Reflections")
                .font(.title)
            
            Spacer()
            
            TrendsHelpButton(showingHelpInfo: $showingHelpInfo)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
