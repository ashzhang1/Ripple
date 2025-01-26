//
//  Calendar+Extensions.swift
//  Ripple
//
//  Created by Ashley Zhang on 10/1/2025.
//

import Foundation
import os  // Add this at the top of your file

// extensions lets you add additional functionality to an existing type
// this extension is to calculate how many unique months there are

extension Calendar {
    
    private static let logger = Logger(subsystem: "com.yourapp.ripple", category: "Calendar")
    
    func startOfWeek(for date: Date) -> Date? {
        let components = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return self.date(from: components) ?? date
    }
    
    func startOfMonth(for date: Date) -> Date? {
        let components = dateComponents([.year, .month], from: date)
        return self.date(from: components) ?? date
    }
    
    func numberOfDays(in date: Date) -> Int {
        range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    func firstWeekday(of date: Date) -> Int {
        guard let firstDay = startOfMonth(for: date) else {
            Self.logger.error("Failed to get start of month for date: \(date, privacy: .public)")
            return 0
        }
        let weekday = component(.weekday, from: firstDay)
        return (weekday + 5) % 7
    }

}
