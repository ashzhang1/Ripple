//
//  EmotionIcons.swift
//  Ripple
//
//  Created by Ashley Zhang on 17/1/2025.
//

import Foundation

enum EmotionIcons: String, CaseIterable, EmojiRepresentable {
    case happy
    case motivated
    case relaxed
    case proud
    case tired
    case angry
    case sad
    case stressed
    
    var emoji: String {
        switch self {
        case .happy: return "🙂"
        case .motivated: return "😄"
        case .relaxed: return "😌"
        case .proud: return "🥹"
        case .tired: return "🥱"
        case .angry: return "😡"
        case .sad: return "😥"
        case .stressed: return "😰"
        }
    }
    
    var label: String {
        rawValue.capitalized
    }
}
