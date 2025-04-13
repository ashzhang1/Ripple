//
//  ContextualFactorsItem.swift
//  Ripple
//
//  Created by Ashley Zhang on 12/4/2025.
//

import SwiftUI

struct ContextualFactorsItem<Item: EmojiRepresentable>: View {
    let item: Item
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 52, height: 52)
                
                Text(item.emoji)
                    .font(.system(size: 36))
            }
            .overlay(
                Circle()
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
            
            Text(item.label)
                .font(isSelected ? .bodyCustomMedium : .bodyCustom)
                .foregroundColor(isSelected ? .blue : .primary)
        }
        .padding(.vertical, 12)
        .onTapGesture {
            action()
        }
    }
}
