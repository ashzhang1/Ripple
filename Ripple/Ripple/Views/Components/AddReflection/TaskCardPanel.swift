//
//  TaskCardPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/4/2025.
//

import SwiftUI
import CoreData

struct TaskCardPanel: View {
    let viewContext: NSManagedObjectContext
    
    var body: some View {
        VStack() {
            TaskCard(
                title: "Log Your Activities and Emotions for Today, November 30th",
                dueDate: nil,
                buttonLabel: "Log",
                destination: LogContextualFactors(viewContext: viewContext)
            )
            Spacer()
            TaskCard(
                title: "Record Your Monthly Reflection",
                dueDate: "November 30th",
                buttonLabel: "Record",
                destination: RecordNewReflection(viewContext: viewContext)
            )
        }
        .frame(height: 560)
    }
}
