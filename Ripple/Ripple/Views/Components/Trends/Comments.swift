//
//  ClinicianComments.swift
//  Ripple
//
//  Created by Ashley Zhang on 2/2/2025.
//

import SwiftUI

struct Comments: View {
    let commentData: [CommentDataEntry]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) { // Using LazyHStack for better performance
                ForEach(commentData) { comment in
                    CommentBox(
                        date: comment.date,
                        authorName: comment.authorName,
                        authorType: comment.authorType,
                        authorRelation: comment.authorRelation,
                        comment: comment.comment
                    )
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Comment by \(comment.authorName)")
                }
            }
            .padding()
        }
        .accessibilityHint("Scroll horizontally to view more comments")
    }
}

