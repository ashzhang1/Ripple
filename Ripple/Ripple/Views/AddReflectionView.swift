//
//  AddReflectionView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI
import CoreData

struct AddReflectionView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                AddReflectionHeader()
                
                Spacer()
                
                HStack(spacing: 20) {
                    AddReflectionInfoPanel()
                    
                    TaskCardPanel()
                }
                
                Spacer()
            }
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}
