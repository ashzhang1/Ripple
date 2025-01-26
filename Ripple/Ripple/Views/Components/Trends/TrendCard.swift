//
//  TrendCard.swift
//  Ripple
//
//  Created by Ashley Zhang on 26/1/2025.
//

import SwiftUI

struct TrendCard: View {
    let trendTitle: String
    let trendDescription: String
    
    var body: some View {
        VStack {
            Text(trendTitle)
            Text(trendDescription)
        }
    }
}
