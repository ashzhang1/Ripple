//
//  MyReflectionsView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI

struct MyReflectionsView: View {
    var body: some View {
        Text("My Reflections")
    }
}

#Preview("11-inch iPad Pro", traits: .landscapeRight) {
    MyReflectionsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
