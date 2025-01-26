//
//  MonthlyStepAverage.swift
//  Ripple
//
//  Created by Ashley Zhang on 25/1/2025.
//
import CoreData

// This is a derived type so dont need to add it to the xcdatamodeld file
struct StepAverage: Identifiable {
    let id = UUID()
    let period: Date    // This will denote the start of week or month
    let average: Double
    let label: String   // "Week 1" or "January"
}
