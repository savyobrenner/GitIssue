//
//  IssueData.swift
//  Challenge_GitIssues
//
//  Created by Brenner on 06/06/20.
//  Copyright © 2020 Brenner. All rights reserved.
//

import Foundation

struct Issue: Codable {
    let htmlUrl: String
    let title: String
    let user: User
    let state: String
    let createdAt: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
        case title
        case user
        case state
        case createdAt = "created_at"
        case body
    }
}


