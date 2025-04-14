//
//  AddReflectionHelpModal.swift
//  Ripple
//
//  Created by Ashley Zhang on 14/4/2025.
//

import SwiftUI

struct MyReflectionsHelpModal: View {
    @Binding var isPresented: Bool
    let activitiesViewModel: ActivityDataViewModel
    let emotionsViewModel: EmotionDataViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingConfirmationAlert = false
    
    // Content for the single page
    let content = ModalContent(
        title: "Admin: Removing Last Logged Activities, Emotions and Reflections",
        image: "addReflectionHelpImage",
        description: """
                    This is an admin function.
                    Do not use if you are a research participant.
                    Clicking on this button will remove the last logged activities, emotions and recorded reflection.
                    """
    )
    
    var body: some View {
        VStack(spacing: 12) {
            // Header section with gray background
            VStack {
                HStack {
                    Text("My Reflections Help")
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
                VStack(spacing: 20) {
                    // Main content
                    SingleHelpModalView(content: content)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    Spacer()
                    
                    // Remove button at bottom
                    Button("Remove") {
                        // This button does nothing for now
                        showingConfirmationAlert = true
                    }
                    .font(.headlineSemiBold)
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    // Add alert modifier
                    .alert("Confirm Removal", isPresented: $showingConfirmationAlert) {
                        Button("Yes", role: .destructive) {
                            Task {
                                activitiesViewModel.deleteMostRecent()
                                emotionsViewModel.deleteMostRecent()
                                
                                // Close the modal after deletion
                                isPresented = false
                                print("User confirmed removal")
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            print("User canceled the removal")
                        }
                    } message: {
                        Text("Are you sure you want to remove the last logged activities, emotions, and recorded reflection?")
                    }
                }
                .frame(height: geometry.size.height)
            }
        }
    }
}
