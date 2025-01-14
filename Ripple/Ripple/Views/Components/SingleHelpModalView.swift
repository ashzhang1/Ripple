//
//  SingleHelpModalView.swift
//  Ripple
//
//  Created by Ashley Zhang on 14/1/2025.
//

import SwiftUI

struct ModalContent {
    let title: String
    let image: String
    let description: String
}

struct SingleHelpModalView: View {
    let content: ModalContent
    
    var body: some View {
        VStack(spacing: 12) {
            Text(content.title)
                .font(.titleSemiBold)
            
            Image(content.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 450, maxHeight: 200)
            
            Text(content.description)
                .font(.subheadlineMedium)
                .multilineTextAlignment(.leading)
                .lineSpacing(12)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(Color.grayColour)
                .cornerRadius(8)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }
}
