//
//  MasterAPIClient.swift
//  Watchlist
//
//  Created by TJ Carney on 11/20/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import Foundation
import Alamofire

class MasterAPIClient {
    
    class func plainRequest(url: String, method: HTTPMethod, parameters: [String:Any]?, completion: @escaping ([String:Any]) -> ()) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let json = response.result.value as? [String:Any] ?? [:]
                completion(json)
            }
        }
    }
}
