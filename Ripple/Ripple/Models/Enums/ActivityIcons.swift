//
//  ActivityEnums.swift
//  Ripple
//
//  Created by Ashley Zhang on 17/1/2025.
//

import Foundation

enum ActivityIcons: String, CaseIterable, EmojiRepresentable {
    case walking
    case stretching
    case gym
    case reading
    case cooking
    case gardening
    case chores
    case television
    
    var emoji: String {
        switch self {
        case .walking: return "🚶"
        case .stretching: return "🙆‍♀️"
        case .gym: return "🏋️‍♂️"
        case .reading: return "📖"
        case .cooking: return "🍳"
        case .gardening: return "🪴"
        case .chores: return "🧹"
        case .television: return "📺"
        }
    }
    
    var label: String {
        rawValue.capitalized
    }
}
