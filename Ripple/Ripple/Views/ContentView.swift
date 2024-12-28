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

    @FetchRequest(
        entity: StepData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StepData.stepCount, ascending: true)],
        animation: .default)
    private var items: FetchedResults<StepData>

    var body: some View {
        TabView {
            Tab("Calendar", systemImage: "tray.and.arrow.down.fill") {
                CalendarView()
            }
            
            Tab("Trends", systemImage: "tray.and.arrow.down.fill") {
                TrendsView()
            }


            Tab("Add Reflection", systemImage: "tray.and.arrow.up.fill") {
                AddReflectionView()
            }


            Tab("My Reflections", systemImage: "person.crop.circle.fill") {
                MyReflectionsView()
            }
        }
        .environment(\.horizontalSizeClass, .compact)
    }

    
}


#Preview("11-inch iPad Pro", traits: .landscapeLeft) {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
