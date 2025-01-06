//
//  StepData.swift
//  Ripple
//
//  Created by Ashley Zhang on 6/1/2025.
//

import Foundation

struct StepDataResponse: Codable {
    let steps: [StepDataEntry]
}

struct StepDataEntry: Codable, Identifiable {
    let id: UUID
    let date: Date
    let stepCount: Int
    let wearTime: Double
}
