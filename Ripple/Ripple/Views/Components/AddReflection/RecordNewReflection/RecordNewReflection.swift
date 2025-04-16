//
//  RecordNewReflection.swift
//  Ripple
//
//  Created by Ashley Zhang on 16/4/2025.
//

import SwiftUI
import CoreData

struct RecordNewReflection: View {
    let viewContext: NSManagedObjectContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            AddReflectionHeader()
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                        Text("Back")
                            .font(.headline)
                    }
                }
                .foregroundColor(.blue)
                .padding(.leading, 16)
                
                
                Spacer()
            }
            .padding(.top, 8)
            
            HStack() {
                Image("RecordNewReflectionImage")
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
    }
}
