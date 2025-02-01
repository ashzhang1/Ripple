//
//  InsightTypeSelector.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/2/2025.
//

import SwiftUI

struct InsightTypeSelector: View {
    @ObservedObject var viewModel: TrendsViewModel
    
    var body: some View {
        HStack(spacing: 44) {
            ForEach(TrendsViewModel.AdditionalInsightType.allCases, id: \.self) { insightType in
                InsightTypeButton(
                    insightType: insightType,
                    isSelected: viewModel.isInsightTypeSelected(insightType),
                    action: {
                        viewModel.selectedAdditionalInsightType = insightType
                    }
                )
            }
        }
    }
}
