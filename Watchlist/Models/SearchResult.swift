//
//  Show.swift
//  Watchlist
//
//  Created by TJ Carney on 11/21/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import Foundation

struct SearchResult {
    
    let id: Int
    let title: String
    let imagePath: String
    
    init(params: [String:Any]) {
        self.id = params["id"] as! Int
        self.title = params["name"] as! String
        self.imagePath = params["backdrop_path"] as? String ?? " "
    }
}
