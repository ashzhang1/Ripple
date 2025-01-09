//
//  Calendar+Extensions.swift
//  Ripple
//
//  Created by Ashley Zhang on 10/1/2025.
//

import Foundation

// extensions lets you add additional functionality to an existing type
// this extension is to calculate how many unique months there are

extension Calendar {
    
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.year, .month], from: date)
        return self.date(from: components) ?? date
    }
    
    func numberOfDays(in date: Date) -> Int {
        range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    func firstWeekday(of date: Date) -> Int {
        // Get the first day of the month
        let firstDay = startOfMonth(for: date)
        // Get the weekday (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
        let weekday = component(.weekday, from: firstDay)
        // Convert to our format (0 = Monday, ..., 6 = Sunday)
        return (weekday + 5) % 7
    }

}
