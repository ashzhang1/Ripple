//
//  RippleApp.swift
//  Ripple
//
//  Created by Ashley Zhang on 16/12/2024.
//

import SwiftUI

@main
struct RippleApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        // Load sample data on app launch
        loadSampleDataIfNeeded(context: persistenceController.container.viewContext)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
