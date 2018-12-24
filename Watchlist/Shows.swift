//
//  ShowsStore.swift
//  Watchlist
//
//  Created by TJ Carney on 12/19/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import Foundation

class Shows {
    static private let store = Shows()
    var allShows: [String: [Int]] = [:]
    
    private init(){
        self.allShows = self.retrieveAll()
    }
    
    class func guide() -> Shows {
        return self.store
    }
    
    public func retrieveAll() -> [String: [Int]] {
        if let allTVShows = UserDefaults.standard.dictionary(forKey: "Shows")as? [String: [Int]] {
            return allTVShows
        } else {
            return self.generateDefaultShows()
        }
    }
    
    public func generateDefaultShows() -> [String: [Int]] {
        let shows: [String: [Int]] = ["current" : [], "upcoming": [], "completed": []]
        UserDefaults.standard.setValue(shows, forKey: "Shows")
        return shows
    }
    
    func removeAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func addShow(id: Int, to list: ShowType) {
        self.allShows[list.rawValue]?.append(id)
        UserDefaults.standard.setValue(self.allShows, forKey: "Shows")
    }
    
    func removeShow(id: Int, from list: ShowType) {
        guard var shows = self.allShows[list.rawValue] else {return}
        for (index, showID) in shows.enumerated() {
            if shows.contains(id) {
                if showID == id {
                    shows.remove(at: index)
                }
            }
        }
        self.allShows[list.rawValue] = shows
        UserDefaults.standard.setValue(self.allShows, forKey: "Shows")
    }
    
    func moveShow(id: Int, from: ShowType, to: ShowType) {
        self.removeShow(id: id, from: from)
        self.addShow(id: id, to: to)
    }
}
