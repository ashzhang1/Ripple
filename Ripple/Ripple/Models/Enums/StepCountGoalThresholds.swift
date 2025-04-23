//
//  StepCountGoalThresholds.swift
//  Ripple
//
//  Created by Ashley Zhang on 11/1/2025.
//

import Foundation

enum StepCountGoalThresholds {
    static let goalCompleteDay: Int = 5500
    static let overHalfGoal: Int = 2750
    static let underHalfGoal: Int = 2749
    static let nonWearDay: Double = 7.0
}

enum StepGoalFilter {
    case goalCompleteDay
    case overHalfGoal
    case underHalfGoal
    case nonWearDay
}
