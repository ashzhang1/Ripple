//
//  ContextualFactorsPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/1/2025.
//

import SwiftUI

struct ContextualFactorsPanel: View {
    @ObservedObject var viewModel: TrendsViewModel

    var body: some View {
     VStack {
         HStack(spacing: 44) {
             ForEach(TrendsViewModel.AdditionalInsightType.allCases, id: \.self) { insightType in
                 InsightButton(
                     insightType: insightType,
                     isSelected: viewModel.isInsightTypeSelected(insightType),
                     action: {
                         viewModel.selectedAdditionalInsightType = insightType
                     }
                 )
             }
         }
         
         HStack {
             
         }
         .frame(width: 1120, height: 240)
     }
    }
 }



private struct InsightButton: View {
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
