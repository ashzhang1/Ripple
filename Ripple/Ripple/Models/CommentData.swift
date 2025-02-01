//
//  CommentData.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/2/2025.
//

import Foundation

struct CommentDataResponse: Codable {
    let comments: [CommentDataEntry]
}

struct CommentDataEntry: Codable, Identifiable {
    let id: UUID
    let date: Date
    let authorName: String
    let authorType: String
    let authorRelation: String?
    let comment: String
}
