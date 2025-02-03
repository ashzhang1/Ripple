//
//  StepCountBarChart.swift
//  Ripple
//
//  Created by Ashley Zhang on 26/1/2025.
//

import SwiftUI
import Charts

struct StepCountBarChart: View {
    let data: [StepAverage]
    let goalLine: Int = 2000
    let showTrendLines: Bool
    let firstPeriodAverage: Double
    let secondPeriodAverage: Double
    
    
    // Define ranges for each period
    private let firstPeriodMonths: Range<Int> = 0..<3
    private let secondPeriodMonths: Range<Int> = 3..<6
    
    // Helper computed properties to get data for each period
    private var firstPeriodData: [StepAverage] {
        Array(data[firstPeriodMonths])
    }
    
    private var secondPeriodData: [StepAverage] {
        Array(data[secondPeriodMonths])
    }
    
    
    // Below are computed properties for the trend lines
    private var chartWidth: CGFloat { 720.0 }
    private var chartHeight: CGFloat { 250.0 }
    private var monthWidth: CGFloat { chartWidth / CGFloat(data.count) }
    
    // Helper function for clipping the trend lines correctly
    private func periodClipShape(startMonth: Int, monthCount: Int) -> Path {
        Rectangle().path(in: CGRect(
            x: CGFloat(startMonth) * monthWidth,
            y: 0,
            width: CGFloat(monthCount) * monthWidth,
            height: chartHeight
        ))
    }
    
    var body: some View {
        Chart {
            // Bar marks for the data
            ForEach(data) { stepAverage in
                BarMark(
                    x: .value("Label", stepAverage.label),
                    y: .value("Average Steps", stepAverage.average)
                )
                .foregroundStyle(showTrendLines ? Color.darkGrayColour : Color.overHalfColour)
            }
            
            
            if showTrendLines {
                
                // First trend line
                RuleMark(
                    y: .value("First Period Average", firstPeriodAverage)
                )
                .lineStyle(StrokeStyle(lineWidth: 5))
                .foregroundStyle(Color.green)
                .annotation(position: .top, alignment: .leading) {
                    Text("\(Int(firstPeriodAverage)) steps")
                        .font(.subheadlineMedium)
                        .foregroundColor(.green)
                }
                .clipShape(periodClipShape(startMonth: 0, monthCount: 3))

                // Second trend line
                RuleMark(
                    y: .value("Second Period Average", secondPeriodAverage)
                )
                .lineStyle(StrokeStyle(lineWidth: 5))
                .foregroundStyle(Color.green)
                .annotation(position: .top) {
                    Text("\(Int(secondPeriodAverage)) steps")
                        .font(.subheadlineMedium)
                        .foregroundColor(.green)
                }
                .clipShape(periodClipShape(startMonth: 3, monthCount: 3))
                
            }
            // Trend card not selected, so show og goal line
            else {
                RuleMark(
                    y: .value("Goal", goalLine)
                )
                .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 5])) // Keeps the dotted style
                .foregroundStyle(Color.redColour)
            }
        }
        .frame(width: 720, height: 250)
        .chartYAxis {
            AxisMarks(position: .leading) { mark in
                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                                    .foregroundStyle(Color.gray)
                
                AxisValueLabel {
                    Text("\(mark.as(Int.self) ?? 0)")
                        .font(.subheadlineMedium)
                        .foregroundStyle(Color.black)
                }
            }
        }
        .chartXAxis {
            AxisMarks { mark in
                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                                    .foregroundStyle(Color.gray)
                
                AxisValueLabel {
                    Text(mark.as(String.self) ?? "")
                        .font(.subheadlineMedium)
                        .foregroundStyle(Color.black)
                }
            }
        }
        .chartYScale(domain: 0...6000)
        .padding()
    }
}
