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
    
    /// BigTitle font - 40pt
    static let bigTitle = Font.system(size: 40)
    
    /// Title font - 32pt
    static let title = Font.system(size: 32)
    static let titleMedium = Font.system(size: 32, weight: .medium)
    static let titleSemiBold = Font.system(size: 32, weight: .semibold)
    
    /// Headline font - 24pt
    static let headline = Font.system(size: 24)
    static let headlineSemiBold = Font.system(size: 24, weight: .semibold)
    static let headlineMedium = Font.system(size: 24, weight: .medium)
    
    /// Subheadline font - 20pt
    static let subheadline = Font.system(size: 20)
    static let subheadlineBold = Font.system(size: 20, weight: .bold)
    static let subheadlineSemiBold = Font.system(size: 20, weight: .semibold)
    static let subheadlineMedium = Font.system(size: 20, weight: .medium)
    
    /// Body font - 16pt
    static let bodyCustom = Font.system(size: 16)
    static let bodyCustomMedium = Font.system(size: 16, weight: .medium)
    
    
}
