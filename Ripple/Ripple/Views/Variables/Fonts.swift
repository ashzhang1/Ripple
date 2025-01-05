//
//  Fonts.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI

extension Font {
    /// Display font - 64pt
    static let display = Font.system(size: 64)
    
    /// Title font - 32pt
    static let title = Font.system(size: 32)
    
    /// Headline font - 24pt
    static let headline = Font.system(size: 24)
    
    
    /// Subheadline font - 20pt
    static let subheadline = Font.system(size: 20)
    
    static let subheadlineBold = Font.system(size: 20, weight: .bold)
    
    /// Body font - 16pt
    static let bodyCustom = Font.system(size: 16)
    
    static let bodyCustomMedium = Font.system(size: 16, weight: .medium)
    
    
}
