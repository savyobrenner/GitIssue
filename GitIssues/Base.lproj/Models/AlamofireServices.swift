//
//  AlamofireServices.swift
//  Challenge_GitIssues
//
//  Created by Brenner on 06/06/20.
//  Copyright © 2020 Brenner. All rights reserved.
//
import Foundation
import Alamofire
import AlamofireImage


class AlamofireServices: AlamofireServicesProtocol {
  
    func loadIssues(onSuccess: @escaping ([Issue]) -> Void, onError: @escaping (DataError) -> Void) {
        
        let basePath = "https://api.github.com/repos/apple/swift/issues"

        AF.request(basePath).responseJSON { (response) in
            guard let urlResponse = response.response else {
                onError(.noData)
                return
            }
            if urlResponse.statusCode == 200 {
                guard let data = response.data else {
                    onError(.responseStatusCode(code: urlResponse.statusCode))
                    return
                }
                do {
                    let issuesData = try JSONDecoder().decode([Issue].self, from: data)
                    onSuccess(issuesData)
                }catch{
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }
            }
        }
    }
    
    func loadAvatar(imageUrl: String, onSuccess: @escaping (UIImage) -> Void){
        AF.request(imageUrl).responseImage { (response) in
            if let data = response.data {
                let image = UIImage(data: data)!
                onSuccess(image)
            }
      }
    }
    
}
