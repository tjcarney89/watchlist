//
//  Episode.swift
//  Watchlist
//
//  Created by TJ Carney on 12/3/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    let name: String
    let id: Int
    let description: String
    let seasonNumber: Int
    let episodeNumber: Int
    let date: String?
    let imagePath: String
    
    init(params: [String:Any]) {
        self.name = params["name"] as? String ?? ""
        self.id = params["id"] as? Int ?? 0
        self.description = params["overview"] as? String ?? ""
        self.seasonNumber = params["season_number"] as? Int ?? 0
        self.episodeNumber = params["episode_number"] as? Int ?? 0
        self.imagePath = params["still_path"] as? String ?? ""
        let rawDate = params["air_date"] as? String
        if rawDate != nil {
            self.date = DateFormat.getReadableDate(from: rawDate!)
        } else {
            self.date = nil
        }
        
    }
}
