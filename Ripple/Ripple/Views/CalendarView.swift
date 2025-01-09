//
//  CalendarView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    @StateObject private var viewModel: StepDataViewModel
    @State private var showDates = true
    @State private var showingStepInfo = false
        
    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: StepDataViewModel(viewContext: viewContext))
    }
    
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Text("Calendar")
                    .font(.display)
                
                Spacer()
                
                VStack {
                    Text("Show Dates")
                        .font(.headline)
                    HStack {
                        Text("Off")
                            .font(.subheadline)
                            .foregroundStyle(showDates ? .gray : .black)
                        Toggle("", isOn: $showDates)
                            .labelsHidden()
                        Text("On")
                            .font(.subheadline)
                            .foregroundStyle(showDates ? .black : .gray)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            
            HStack(alignment: .top, spacing: 20) {
                
                // The calendar legend on the left
                CalendarLegend(viewModel: viewModel)
                    .frame(width: 200)
                
                // The actual calendar months
                VStack(spacing: 20) {
                    ForEach(viewModel.displayMonths.indices, id: \.self) { rowIndex in
                        HStack(spacing: 20) {
                            ForEach(viewModel.displayMonths[rowIndex], id: \.self) { monthDate in
                                CalendarMonth(date: monthDate)
                            }
                        }
                    }
                }
                
                Spacer()  // This will push content to the left
            }
            .padding(.horizontal)

            
            HStack(spacing: 70) {
                Button(action: {
                    showingStepInfo = true
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "shoeprints.fill")
                            .font(.title)
                        
                        Text("About Step Count")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                }
                .frame(width: 300, height: 60)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.grayColour)
                .addBorder(Color.clear, width: 1, cornerRadius: 20)
                .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
                .sheet(isPresented: $showingStepInfo) {
                    AboutStepCountModal(isPresented: $showingStepInfo)
                }
                
                Button(action: {
                    // TODO
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "questionmark.circle")
                            .font(.title)
                        
                        Text("Help")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                }
                .frame(width: 150, height: 60)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.grayColour)
                .addBorder(Color.clear, width: 1, cornerRadius: 20)
                .shadow(color: Color.black.opacity(0.7), radius: 4, x: 0, y: 5)
    
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .ignoresSafeArea(edges: .top)
        
        
    }
}

#Preview("11-inch iPad Pro", traits: .landscapeRight) {
    CalendarView(viewContext: PersistenceController.preview.container.viewContext)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


/**
 Below is the scroll view that allows to see the step count for each day (1 June - 30 November)
 ScrollView {
     if viewModel.isLoading {
         ProgressView()
             .frame(maxWidth: .infinity, maxHeight: .infinity)
     } else if let error = viewModel.error {
         VStack {
             Text("Error loading data")
                 .font(.headline)
             Text(error.localizedDescription)
                 .font(.subheadline)
                 .foregroundColor(.red)
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity)
     } else {
         LazyVStack(alignment: .leading, spacing: 8) {
             ForEach(viewModel.stepData) { stepData in
                 HStack {
                     Text(stepData.date, style: .date)
                         .font(.subheadline)
                         .foregroundColor(.gray)
                     Spacer()
                     Text("\(stepData.stepCount) steps")
                         .font(.headline)
                 }
                 .padding(.vertical, 4)
                 .padding(.horizontal)
                 .background(Color(UIColor.secondarySystemBackground))
                 .cornerRadius(8)
             }
         }
         .padding()
     }
 }
 .frame(maxWidth: .infinity)
 .refreshable {
     viewModel.refreshStepCount()
 }

 
 
 */
