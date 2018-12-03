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
    
    
    
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
}
