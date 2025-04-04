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
    let goalLine: Int = 3000
    let firstPeriodAverages: (stepCount: Double, wearTime: Double)
    let secondPeriodAverages: (stepCount: Double, wearTime: Double)
    
    
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
    
    private func barColour(value: Double) -> Color {
        switch value {
            case ..<4.0:
                return .lightestGreenColour
            case 4.0..<7.0:
                return .mediumLightGreenColour
            case 7.0..<10.0:
                return .mediumDarkGreenColour
            case 10.0...:
                return .darkestGreenColour
            default:
                return .blue
        }
    }
    
    var body: some View {
        Chart {
            // Bar marks for the data
            ForEach(data) { stepAverage in
                BarMark(
                    x: .value("Label", stepAverage.label),
                    y: .value("Average Steps", stepAverage.averageStepCount)
                )
                .foregroundStyle(barColour(value: stepAverage.averageWearTime))
            }
            
            // Goal line
            RuleMark(
                y: .value("Goal", goalLine)
            )
            .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 5])) // Keeps the dotted style
            .foregroundStyle(Color.orangeColour)
            
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
