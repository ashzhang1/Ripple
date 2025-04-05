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
            TaskCard()
            Spacer()
            TaskCard()
        }
        .frame(height: 560)
    }
}
