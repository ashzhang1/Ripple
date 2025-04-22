//
//  CalendarHelpModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 14/1/2025.
//

import SwiftUI

struct HelpModal: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0
    
    let pages: [ModalContent] = [
        ModalContent(title: "Calendar Page",
                     image: "CalendarHelpImage",
                     description: """
                                Use the calendar to see how your step count compares to your daily goal. Click on a month to explore your activity for that month. Use the filters on the left to highlight the days when you reached different goal levels.
                                """),
        ModalContent(title: "Trends Page",
                     image: "TrendsHelpImage",
                     description: """
                     Use the graph to identify if your step count has gone up or down over time.
                     You can also view comments from your supporters and clinicians, along with the top activities and emotions you’ve logged. These can help you understand what may have affected your steps.
                     """),
        ModalContent(title: "Add Reflection Page",
                     image: "AddReflectionHelpImage",
                     description: """
                     On the Add Reflection page, you can record what you did and how you felt each day. You can also record your monthly reflection by speaking instead of typing.
                     """),
        ModalContent(title: "My Reflections Page",
                     image: "MyReflectionsHelpImage",
                     description: """
                     On the My Reflections page, you can review your past reflections and see your most logged activities and emotions on Ripple.
                     """)
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            
            // Header section with gray background
            VStack {
                HStack {
                    Text("Help: How to Use Ripple")
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


