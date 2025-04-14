//
//  MyReflectionsHeader.swift
//  Ripple
//
//  Created by Ashley Zhang on 4/2/2025.
//

import SwiftUI

struct MyReflectionsHeader: View {
    @State private var showingHelpInfo = false
    let activitiesViewModel: ActivityDataViewModel
    let emotionsViewModel: EmotionDataViewModel
    
    
    var body: some View {
        HStack {
            Text("My Past Reflections")
                .font(.title)
            
            Spacer()
            
            MyReflectionsHelpButton(
                showingHelpInfo: $showingHelpInfo,
                activitiesViewModel: activitiesViewModel,
                emotionsViewModel: emotionsViewModel
            )
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
