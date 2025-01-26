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
    
    var body: some View {
        Chart {
            // Bar marks for the data
            ForEach(data) { stepAverage in
                BarMark(
                    x: .value("Label", stepAverage.label),
                    y: .value("Average Steps", stepAverage.average)
                )
                .foregroundStyle(Color.overHalfColour)
            }
            
            // Goal line
            RuleMark(
                y: .value("Goal", goalLine)
            )
            .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 5])) // Makes it dotted
            .foregroundStyle(Color.redColour)
        }
        .frame(width: 700, height: 300)
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
