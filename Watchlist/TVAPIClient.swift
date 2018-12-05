//
//  TVAPIClient.swift
//  Watchlist
//
//  Created by TJ Carney on 11/20/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import Foundation
import Alamofire

class TVAPIClient {
    
    class func searchShow(query: String, completion: @escaping ([SearchResult]) -> ()) {
        
        let urlQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = baseURL + "/search/tv?api_key=" + APIKey + "&query=" + urlQuery!
        
        MasterAPIClient.plainRequest(url: url, method: .get, parameters: nil) { (json) in
            let resultsArray = json["results"] as? [[String:Any]] ?? [[:]]
            var searchResults: [SearchResult] = []
            for result in resultsArray {
                let newResult = SearchResult(params: result)
                searchResults.append(newResult)
            }
            completion(searchResults)
        }
        
    }
    
    class func fetchShowDetails(showID: Int, completion: @escaping (TVShow) -> ()) {
        let url = baseURL + "/tv/\(showID)?api_key=" + APIKey
        
        MasterAPIClient.plainRequest(url: url, method: .get, parameters: nil) { (json) in
            let show = TVShow(json: json)
            completion(show)
        }
    }
    
    class func fetchPopularShows(page: Int, completion: @escaping ([SearchResult]) -> ()) {
        let url = baseURL + "/tv/popular?api_key=" + APIKey + "&page=\(page)"
        
        MasterAPIClient.plainRequest(url: url, method: .get, parameters: nil) { (json) in
            print(json)
            let showsArray = json["results"] as? [[String:Any]] ?? [[:]]
            var resultsArray: [SearchResult] = []
            for show in showsArray {
                let newResult = SearchResult(params: show)
                resultsArray.append(newResult)
            }
            completion(resultsArray)
        }
    }
    
}
