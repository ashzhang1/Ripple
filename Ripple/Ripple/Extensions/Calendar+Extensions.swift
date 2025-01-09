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
}
