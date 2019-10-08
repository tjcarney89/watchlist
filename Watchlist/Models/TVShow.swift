//
//  TVShow.swift
//  Watchlist
//
//  Created by TJ Carney on 11/27/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import Foundation
import MobileCoreServices

final class TVShow: NSObject, NSItemProviderWriting, NSItemProviderReading, Codable {
    
    let name: String
    let id: Int
    let overview: String
    let lastEpisode: Episode
    let nextEpisode: Episode
    let networks: [String]
    let status: String
    let imagePath: String
    let seasons: Int
    var showType: ShowType? = nil
    
    
    init(name: String, id: Int, overview: String, lastEpisode: Episode, nextEpisode: Episode, networks: [String], status: String, seasons: Int, imagePath: String, showType: ShowType) {
        self.name = name
        self.id = id
        self.overview = overview
        self.lastEpisode = lastEpisode
        self.nextEpisode = nextEpisode
        self.networks = networks
        self.status = status
        self.imagePath = imagePath
        self.showType = showType
        self.seasons = seasons
    }
    
    init(json: [String:Any]) {
        self.name = json["name"] as? String ?? ""
        let id = json["id"] as? Int ?? 0
        self.id = id
        self.overview = json["overview"] as? String ?? ""
        let lastEpisodeDict = json["last_episode_to_air"] as? [String:Any] ?? [:]
        let nextEpisodeDict = json["next_episode_to_air"] as? [String:Any] ?? [:]
        self.lastEpisode = Episode(params: lastEpisodeDict)
        self.nextEpisode = Episode(params: nextEpisodeDict)
        let networkArray = json["networks"] as? [[String:Any]] ?? [[:]]
        var networkNames: [String] = []
        for network in networkArray {
            let newNetwork = network["name"] as? String ?? ""
            networkNames.append(newNetwork)
        }
        self.networks = networkNames
        self.status = json["status"] as? String ?? ""
        self.seasons = json["number_of_seasons"] as? Int ?? 0
        self.imagePath = json["backdrop_path"] as? String ?? ""
        
        var showType: ShowType? = nil
        for (key, value) in Shows.guide().allShows {
            for showID in value {
                if showID == id {
                    let type = key.lowercased()
                    showType = ShowType(rawValue: type)
                }
            }
        }
        self.showType = showType
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        //We know that we want to represent our object as a data type, so we'll specify that
        return [(kUTTypeData as String)]
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        //We know we want to accept our object as a data representation, so we'll specify that here
        return [(kUTTypeData) as String]
    }
    
    
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        
        let progress = Progress(totalUnitCount: 100)
        
        do {
            //Here the object is encoded to a JSON data object and sent to the completion handler
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
    
    //This function actually has a return type of Self, but that really messes things up when you are trying to return your object, so if you mark your class as final as I've done above, the you can change the return type to return your class type.
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> TVShow {
        let decoder = JSONDecoder()
        do {
            //Here we decode the object back to it's class representation and return it
            let show = try decoder.decode(TVShow.self, from: data)
            return show
        } catch {
            fatalError(error as! String)
        }
    }
    
    
    
    
}
