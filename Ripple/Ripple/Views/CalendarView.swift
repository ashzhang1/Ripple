//
//  CalendarView.swift
//  Ripple
//
//  Created by Ashley Zhang on 28/12/2024.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    @State private var showDates = true
    @StateObject private var viewModel: StepDataViewModel
        
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
            
            HStack(alignment: .top, spacing: 16) {
                CalendarLegend(viewModel: viewModel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
            }
            .padding(.horizontal)

            
            HStack(spacing: 70) {
                Button(action: {
                    // TODO
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "shoeprints.fill")
                            .font(.title)
                        
                        Text("About Step Count")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                }
                .padding(.horizontal, 52)
                .padding(.vertical, 20)
                .background(Color(hue: 0, saturation: 0, brightness: 0.85, opacity: 1.0))
                .addBorder(Color.clear, width: 1, cornerRadius: 8)
                
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
                .padding(.horizontal, 44)
                .padding(.vertical, 20)
                .background(Color(hue: 0, saturation: 0, brightness: 0.85, opacity: 1.0))
                .addBorder(Color.clear, width: 1, cornerRadius: 8)
                
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
