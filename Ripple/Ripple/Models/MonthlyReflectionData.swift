//
//  MonthlyReflectionData.swift
//  Ripple
//
//  Created by Ashley Zhang on 5/2/2025.
//

import Foundation

struct MonthlyReflectionDataResponse: Codable {
    let reflections: [MonthlyReflectionDataEntry]
}

struct MonthlyReflectionDataEntry: Codable, Identifiable {
    let id: UUID
    let recordedDate: Date
    let reflectionMonth: Int16
    let question: String
    let response: String?
}
