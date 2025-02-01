//
//  CommentAuthorTypes.swift
//  Ripple
//
//  Created by Ashley Zhang on 1/2/2025.
//

enum CommentAuthorTypes: String {
    case clinician = "clinician"
    case supporter = "supporter"
    
    var displayName: String {
        switch self {
        case .clinician: return "Clinician"
        case .supporter: return "Supporter"
        }
    }
}
