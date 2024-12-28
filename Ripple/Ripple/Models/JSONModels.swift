//
//  JSONModels.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import Foundation

// For stepData.json
struct StepDataResponse: Codable {
    let steps: [StepDataEntry]
}

struct StepDataEntry: Codable {
    let id: UUID
    let date: Date
    let stepCount: Int
    let wearTime: Double
}

// For questions.json
struct QuestionResponse: Codable {
    let questions: [QuestionEntry]
}

struct QuestionEntry: Codable {
    let id: UUID
    let questionText: String
}

// For reflections.json
struct ReflectionResponse: Codable {
    let reflections: [ReflectionEntry]
}

struct ReflectionEntry: Codable {
    let id: UUID
    let date: Date
    let questionId: UUID
    let activities: String
    let emotions: String
    let response: String
}
