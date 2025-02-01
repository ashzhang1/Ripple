//
//  InsightTypeButton.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/2/2025.
//

import SwiftUI

struct InsightTypeButton: View {
    let insightType: TrendsViewModel.AdditionalInsightType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
     Button(action: {
         action()
     }) {
         Text(insightType.rawValue)
             .font(isSelected ? .subheadlineBold : .subheadlineSemiBold)
             .foregroundColor(isSelected ? .white : .gray)
     }
     .frame(width: 275, height: 44)
     .padding(.horizontal, 8)
     .padding(.vertical, 4)
     .background(isSelected ? Color.blue : Color.grayColour)
     .addBorder(Color.clear, width: 1, cornerRadius: 20)
     .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
    }
}
