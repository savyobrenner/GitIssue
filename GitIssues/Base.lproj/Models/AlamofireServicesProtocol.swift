//
//  AlamofireServicesProtocol.swift
//  Challenge_GitIssues
//
//  Created by Brenner on 06/06/20.
//  Copyright © 2020 Brenner. All rights reserved.
//

import Foundation
import UIKit

protocol AlamofireServicesProtocol {
    func loadIssues(onSuccess: @escaping ([Issue]) -> Void, onError: @escaping (DataError) -> Void)
    func loadAvatar(imageUrl: String,onSuccess: @escaping (UIImage) -> Void)
}
