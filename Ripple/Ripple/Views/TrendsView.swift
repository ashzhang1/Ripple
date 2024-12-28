//
//  TrendsView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI

struct TrendsView: View {
    var body: some View {
        Text("Trends")
    }
}

#Preview("11-inch iPad Pro", traits: .landscapeLeft) {
    TrendsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
