//
//  DataError.swift
//  Challenge_GitIssues
//
//  Created by Brenner on 06/06/20.
//  Copyright © 2020 Brenner. All rights reserved.
//

import Foundation
enum DataError {
    case url
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}
