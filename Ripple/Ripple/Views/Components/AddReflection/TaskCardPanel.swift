//
//  TaskCardPanel.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/4/2025.
//

import SwiftUI

struct TaskCardPanel: View {
    var body: some View {
        VStack() {
            TaskCard(
                title: "Record Your Monthly Reflection",
                dueDate: "November 30th",
                buttonLabel: "Record"
            ) {
                print("TaskCard tapped!")
            }
            Spacer()
            TaskCard(
                title: "Log Your Activities and Emotions for Today, December 1st",
                dueDate: nil,
                buttonLabel: "Log"
            ) {
                print("TaskCard tapped!")
            }
        }
        .frame(height: 560)
    }
}
