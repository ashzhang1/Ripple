//
//  DetailedCalendarMonth.swift
//  Ripple
//
//  Created by Ashley Zhang on 15/1/2025.
//

import SwiftUI

struct DetailedCalendarMonth: View {
    let date: Date
    let stepData: [StepDataEntry]
    
    // This is needed for the background colour of each date
    let goalCompleteThreshold: Int
    let overHalfThreshold: Int
    let underHalfThreshold: Int
    let nonWearThreshold: Double
    let selectedFilter: StepGoalFilter?
    
    let weekdays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    
    private var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date)
    }
    
    private var calendar: Calendar {
        Calendar.current
    }
    
    private var numberOfDays: Int {
        calendar.numberOfDays(in: date)
    }
    
    private var firstWeekdayIndex: Int {
        calendar.firstWeekday(of: date)
    }
    
    // This computed property is used for calculating the weeks and days displayed for each month
    private var weeks: [[Int?]] {
        var result: [[Int?]] = []
        var currentWeek: [Int?] = Array(repeating: nil, count: 7)
        var dayCount = 1
        
        // First week - handle the offset
        for i in 0..<7 {
            if (i >= firstWeekdayIndex && dayCount <= numberOfDays) {
                currentWeek[i] = dayCount
                dayCount += 1
            } else {
                currentWeek[i] = nil
            }
        }
        result.append(currentWeek)
        
        // Middle weeks
        while dayCount <= numberOfDays {
            currentWeek = Array(repeating: nil, count: 7)
            for i in 0..<7 {
                if dayCount <= numberOfDays {
                    currentWeek[i] = dayCount
                    dayCount += 1
                } else {
                    currentWeek[i] = nil
                }
            }
            result.append(currentWeek)
        }
        
        return result
    }
    
    private var averageStepsForMonth: Int {
        
        // Filter step data for current month
        let stepsInMonth = stepData.filter { stepEntry in
            Calendar.current.isDate(stepEntry.date, equalTo: date, toGranularity: .month)
        }
        
        // Calculate average
        let totalSteps = stepsInMonth.reduce(0) { $0 + $1.stepCount }
        let daysCount = stepsInMonth.count
        
        // Return 0 if no data
        guard daysCount > 0 else { return 0 }
        
        return totalSteps / daysCount
    }
    
    private func dateBoxContent(_ day: Int) -> some View {
        
        // Get the date
        let calendar = Calendar.current
        guard let dateForDay = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: day
        )) else {
            return AnyView(Rectangle().fill(Color.blue))
        }
        
        if let dayData = stepData.first(where: { calendar.isDate($0.date, inSameDayAs: dateForDay) }) {
            // Get the category
            let dayThresholdCategory = getDayCategory(for: dayData)
            
            // Get the colour
            switch dayThresholdCategory {
                case .goalCompleteDay:
                    return AnyView(Rectangle().fill(Color.goalReachedColor))
                case .overHalfGoal:
                    return AnyView(Rectangle().fill(Color.overHalfColor))
                case .underHalfGoal:
                    return AnyView(Rectangle().fill(Color.underHalfColor))
                case .nonWearDay:
                    return AnyView(NonWearDayBoxPattern())
            }
        }
        
        return AnyView(Rectangle().fill(Color.blue))
    }
    
    func getDayCategory(for dayData: StepDataEntry) -> StepGoalFilter {
        // Check if non-wear first
        if (dayData.wearTime < StepCountGoalThresholds.nonWearDay) {
            return .nonWearDay
        }
        
        // Then check the step counts
        if (dayData.stepCount >= StepCountGoalThresholds.goalCompleteDay) {
            return .goalCompleteDay
        } else if (dayData.stepCount >= StepCountGoalThresholds.overHalfGoal) {
            return .overHalfGoal
        } else {
            return .underHalfGoal
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(month)
                .font(.bigTitle)
                .padding(.leading, 16)
            
            VStack(spacing: 4) {
                // Weekday headers
                HStack(spacing: 2) {
                    ForEach(weekdays, id: \.self) { day in
                        Text(day)
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 16)
                
                // Month grid
                VStack(spacing: 2) {
                    ForEach(weeks.indices, id: \.self) { weekIndex in
                        HStack(spacing: 4) {
                            ForEach(0..<7) { dayIndex in
                                if let date = weeks[weekIndex][dayIndex] {
                                    // These are the date boxes
                                    ZStack {
                                        dateBoxContent(date)
                                        
                                        Text("\(date)")
                                            .foregroundColor(.black)
                                            .font(.headline)
                                    }
                                    .aspectRatio(1.0, contentMode: .fit)
                                    
                                } else {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .aspectRatio(1.0, contentMode: .fit)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                    
            }
            
            HStack {
                Text("\(month) Average:")
                    .foregroundColor(.red)
                Text("\(averageStepsForMonth) Steps")
                    .foregroundColor(.black)
            }
            .font(.headlineMedium)
            .padding(.leading, 16)

                
            
            Spacer()
        }
        .frame(width: 460, height: 440)
    }
}
