//
//  MyReflectionsView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI

struct MyReflectionsView: View {
    var body: some View {
        
        VStack {
            MyReflectionsHeader()
            
            MyReflectionsGrid()
        }
        .ignoresSafeArea(.container, edges: .top)
        
        
    }
}
