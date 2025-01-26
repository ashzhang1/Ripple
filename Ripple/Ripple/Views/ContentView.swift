//
//  ContentView.swift
//  Ripple
//
//  Created by Ashley Zhang on 16/12/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    

    var body: some View {
        TabView {
            Tab("Calendar", systemImage: "calendar") {
                CalendarView(viewContext: viewContext)
            }
            
            Tab("Trends", systemImage: "chart.line.uptrend.xyaxis") {
                TrendsView(viewContext: viewContext)
            }


            Tab("Add Reflection", systemImage: "plus.circle") {
                AddReflectionView()
            }


            Tab("My Reflections", systemImage: "book.pages") {
                MyReflectionsView()
            }
        }

    }

    
}


#Preview("11-inch iPad Pro", traits: .landscapeRight) {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
