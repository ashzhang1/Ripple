//
//  CalendarMonth.swift
//  Ripple
//
//  Created by Ashley Zhang on 7/1/2025.
//

import SwiftUI

struct CalendarMonth: View {
    let date: Date
    let showDates: Bool
    let stepData: [StepDataEntry]
    
    //this is needed for the background colour of each date
    let goalCompleteThreshold: Int
    let overHalfThreshold: Int
    let underHalfThreshold: Int
    let nonWearThreshold: Double
    let selectedFilter: StepGoalFilter?
    
    let weekdays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    
    private var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
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
    
    // this computed property is used for calculating the weeks and days displayed for each month
    private var weeks: [[Int?]] {
        var result: [[Int?]] = []
        var currentWeek: [Int?] = Array(repeating: nil, count: 7)
        var dayCount = 1
        
        // First week - handle the offset
        for i in 0..<7 {
            if i >= firstWeekdayIndex && dayCount <= numberOfDays {
                currentWeek[i] = dayCount
                dayCount += 1
            } else {
                currentWeek[i] = nil //this is for the case when the month doesnt start on a Monday
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
                    currentWeek[i] = nil //this is for when the last week of month doesnt end on Sunday
                }
            }
            result.append(currentWeek)
        }
        
        return result
    }
    
    //this function determines what colour background each date will be
    private func dateBoxContent(_ day: Int) -> some View {
        
        //get the date
        let calendar = Calendar.current
        guard let dateForDay = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: day
        )) else {
            return AnyView(Rectangle().fill(Color.blue))
        }
        
        if let dayData = stepData.first(where: { calendar.isDate($0.date, inSameDayAs: dateForDay) }) {
            
            //first we get the category
            let dayThresholdCategory = getDayCategory(for: dayData)
            
            let color: Color
            //then, we need to check if there is a filter on
            //if there is, then we only show the dates that align with selected filter
            switch dayThresholdCategory {
                case .goalCompleteDay:
                    if selectedFilter == nil || selectedFilter == .goalCompleteDay {
                        color = Color.goalReachedColor
                    } else {
                        color = Color.gray.opacity(0.3)
                    }
                    
                case .overHalfGoal:
                    if selectedFilter == nil || selectedFilter == .overHalfGoal {
                        color = Color.overHalfColor
                    } else {
                        color = Color.gray.opacity(0.3)
                    }
                    
                case .underHalfGoal:
                    if selectedFilter == nil || selectedFilter == .underHalfGoal {
                        color = Color.underHalfColor
                    } else {
                        color = Color.gray.opacity(0.3)
                    }
                    
                case .nonWearDay:
                    if selectedFilter == nil || selectedFilter == .nonWearDay {
                        return AnyView(NonWearDayBoxPattern())
                    } else {
                        color = Color.gray.opacity(0.3)
                    }
            }
            
            // Return the appropriate view based on the color
            return AnyView(Rectangle().fill(color))
        }
        
        return AnyView(Rectangle().fill(Color.blue))
    }
    
    func getDayCategory(for dayData: StepDataEntry) -> StepGoalFilter {
        // check if non-wear first
        if dayData.wearTime < StepCountGoalThresholds.nonWearDay {
            return .nonWearDay
        }
        
        //then check the step counts
        if dayData.stepCount >= StepCountGoalThresholds.goalCompleteDay {
            return .goalCompleteDay
        } else if dayData.stepCount >= StepCountGoalThresholds.overHalfGoal {
            return .overHalfGoal
        } else {
            return .underHalfGoal
        }
    }
    
    var body: some View {
        ZStack {
            // Box background
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.grayColour)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(month)
                    .font(.headlineMedium)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                
                VStack(spacing: 4) {
                    // Weekday headers
                    HStack(spacing: 2) {
                        ForEach(weekdays, id: \.self) { day in
                            Text(day)
                                .font(.bodyCustom)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    // Calendar grid
                    VStack(spacing: 2) {
                        ForEach(weeks.indices, id: \.self) { weekIndex in
                            HStack(spacing: 4) {
                                ForEach(0..<7) { dayIndex in
                                    if let date = weeks[weekIndex][dayIndex] {
                                        
                                        // These are the date boxes
                                        ZStack {
                                            dateBoxContent(date)
                                            
                                            if showDates {
                                                Text("\(date)")
                                                    .foregroundColor(.black)
                                                    .font(.bodyCustom)
                                            }
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
                
                Spacer()
            }
        }
        .frame(width: 275, height: 275)
    }
}
