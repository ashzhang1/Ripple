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
        VStack(spacing: 16) {
            AddReflectionHeader()
            
            Spacer()
            
            HStack() {
                AddReflectionInfoPanel()
                
                
            }
            
            Spacer()
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}
