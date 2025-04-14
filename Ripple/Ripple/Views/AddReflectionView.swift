//
//  AddReflectionView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI
import CoreData

struct AddReflectionView: View {
    let viewContext: NSManagedObjectContext
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                AddReflectionHeader()
                Spacer()
                
                HStack(spacing: 20) {
                    AddReflectionInfoPanel()
                    
                    TaskCardPanel(viewContext: viewContext)
                }
                
                Spacer()
            }
            .ignoresSafeArea(.container, edges: .top)
            .navigationBarHidden(true) // Need this here or else help button can't be clicked in the header
        }
    }
}
