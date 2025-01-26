//
//  TrendsHelpModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 25/1/2025.
//
import SwiftUI

struct TrendsHelpModal: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0
    
    let pages: [ModalContent] = [
        ModalContent(title: "How to navigate Ripple",
                     image: "navigationHelpImage",
                     description: """
                                Calendar: See how many days you met your step count goal.
                                Trends: Spot increases or decreases in steps or wear time.
                                Add Reflection: Log activities, emotions, or monthly reflections.
                                My Reflections: View your past reflections.
                                """),
        ModalContent(title: "Each legend box is interactive",
                     image: "CalendarLegendHelpImage",
                     description: """
                     Tap a legend box to filter the calendar and see how many days fall into that category for each month. 
                     Tap on the same legend box again to remove the filter.
                     """),
        ModalContent(title: "Toggle the dates on and off",
                     image: "CalendarShowDatesHelpImage",
                     description: """
                     Tap on the toggle to display dates on the calendar, making it easier to find and explore specific days.
                     """),
        ModalContent(title: "Dive into your monthly details",
                     image: "CalendarMonthHelpImage",
                     description: """
                     Tap on a month to see detailed insights, including your average step count, wear-time data, and the top activities and emotions you logged the most.
                     """)
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            
            // Header section with gray background
            VStack {
                HStack {
                    Text("Calendar Page Help")
                        .font(.headlineMedium)
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        VStack {
                            Image(systemName: "pip.exit")
                                .font(.title)
                                .foregroundColor(Color.redColour)
                            Text("Exit")
                                .font(.bodyCustomMedium)
                                .foregroundColor(Color.redColour)
                        }
                    }
                }
                .padding()
            }
            .background(Color.grayColour)
            
            // Content section
            GeometryReader { geometry in
                VStack(spacing: 0) {  // Remove spacing here to control it manually
                    TabView(selection: $currentPage) {
                        ForEach(pages.indices, id: \.self) { index in
                            SingleHelpModalView(content: pages[index])
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        }
                    }
                    .tabViewStyle(.page)
                    
                    // Fixed button section at bottom
                    VStack {
                        if currentPage == pages.count - 1 {
                            Button("Done") {
                                isPresented = false
                            }
                            .font(.headlineSemiBold)
                        } else {
                            Button("Next") {
                                withAnimation {
                                    currentPage += 1
                                }
                            }
                            .font(.headlineSemiBold)
                        }
                    }
                    .frame(height: 60)  // Fixed height for button section
                    .padding(.bottom)
                }
                .frame(height: geometry.size.height)
            }
        }
    }
}
