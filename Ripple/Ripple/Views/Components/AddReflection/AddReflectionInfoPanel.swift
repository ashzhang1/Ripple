//
//  AddReflectionInformation.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/4/2025.
//

import SwiftUI

struct AddReflectionInfoPanel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("How recording reflections can help you 💭")
                .font(.titleMedium)
            
            Text("Recording your reflections each month can help you see how different aspects of your daily life affect your step count.")
                .font(.headline)
            
            Text("Looking back over time can reveal patterns you might not have noticed, helping you make informed choices to support your health.")
                .font(.headline)
            
            Text("The more you log your activities and feelings, the easier it becomes to spot connections between them and your step count.")
                .font(.headline)
        }
        .padding(20)
        .frame(width: 500, height: 560, alignment: .top)
        .background(Color.lightBlueColour)
        .cornerRadius(12)
    }
}
