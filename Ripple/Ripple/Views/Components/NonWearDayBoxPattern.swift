//
//  NonWearDayBoxPattern.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/1/2025.
//

import SwiftUI

struct NonWearDayBoxPattern: View {
    var body: some View {
        Canvas { context, size in
            // Define stripe properties
            let stripeWidth: CGFloat = 2
            let spacing: CGFloat = 4
            let angle = CGFloat.pi / 4 // 45 degrees
            
            // Create background first
            let background = Path(CGRect(origin: .zero, size: size))
            context.fill(background, with: .color(Color(red: 217/255, green: 217/255, blue: 217/255)))
            
            // Calculate diagonal for full coverage (multiply by 2 for safety)
            let diagonal = sqrt(pow(size.width, 2) + pow(size.height, 2)) * 2
            let numberOfStripes = Int(diagonal / (stripeWidth + spacing)) + 1
            
            // Set up the coordinate system for rotation
            // Move to center
            context.translateBy(x: size.width/2, y: size.height/2)
            context.rotate(by: .radians(angle))
            // Instead of moving back, extend the drawing area
            context.translateBy(x: -diagonal/2, y: -diagonal/2)
            
            // Draw stripes across extended area
            for i in -numberOfStripes...numberOfStripes {
                let x = CGFloat(i) * (stripeWidth + spacing)
                let stripePath = Path(CGRect(x: x, y: 0, width: stripeWidth, height: diagonal))
//                context.fill(stripePath, with: .color(Color(red: 176/255, green: 176/255, blue: 176/255)))
                context.fill(stripePath, with: .color(Color(red: 255/255, green: 255/255, blue: 0/255)))
            }
        }
    }
}
