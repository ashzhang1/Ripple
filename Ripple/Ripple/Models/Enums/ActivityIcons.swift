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
    case balanceTraining
    case television
    
    var emoji: String {
        switch self {
        case .walking: return "🚶"
        case .stretching: return "🙆‍♀️"
        case .gym: return "🏋️‍♂️"
        case .reading: return "📖"
        case .cooking: return "🍳"
        case .gardening: return "🪴"
        case .balanceTraining: return "🧘"
        case .television: return "📺"
        }
    }
    
    var label: String {
        switch self {
        case .television:
            return "Television & Entertainment"
        case .balanceTraining:
            return "Balance Training"
        default:
            return rawValue.capitalized
        }
    }
}
