//
//  MonthlyReflection+Extensions.swift
//  Ripple
//
//  Created by Ashley Zhang on 6/2/2025.
//

import Foundation
import os

extension MonthlyReflectionDataEntry {
    var shortMonthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        
        // Create date components for first day of the month
        var components = DateComponents()
        components.month = Int(reflectionMonth)
        components.day = 1
        components.year = 2024  // Any year would work
        
        if let date = Calendar.current.date(from: components) {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    var fullMonthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
        
        var components = DateComponents()
        components.month = Int(reflectionMonth)
        components.day = 1
        components.year = 2024
        
        if let date = Calendar.current.date(from: components) {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    var monthAsDate: Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2024  // Since its only working with 2024 data
        dateComponents.month = Int(reflectionMonth)
        dateComponents.day = 1      // Just use first day of the month to make it easy

        return calendar.date(from: dateComponents)
    }
    
    var isEmpty: Bool {
        reflectionQuestion == nil
        && reflectionResponse == nil
        && recordedDate == nil
    }
}
