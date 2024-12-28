//
//  View.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//
import SwiftUI

extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
    
    
    public func addShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
    }
 }
