//
//  ActivityData.swift
//  Ripple
//
//  Created by Ashley Zhang on 20/1/2025.
//

import Foundation

struct ActivityDataResponse: Codable {
    let activities: [ActivityDataEntry]
}

struct ActivityDataEntry: Codable, Identifiable {
    let id: UUID
    let date: Date
    let activityType: String
}
