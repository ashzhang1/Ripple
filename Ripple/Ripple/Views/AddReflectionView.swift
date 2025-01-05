//
//  AddReflectionView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI

struct AddReflectionView: View {
    var body: some View {
        Text("Add Reflection")
    }
}

#Preview("11-inch iPad Pro", traits: .landscapeRight) {
    AddReflectionView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
