//
//  EmotionData.swift
//  Ripple
//
//  Created by Ashley Zhang on 20/1/2025.
//

import Foundation

struct EmotionDataResponse: Codable {
    let emotions: [EmotionDataEntry]
}

struct EmotionDataEntry: Codable, Identifiable {
    let id: UUID
    let date: Date
    let emotionType: String
}

