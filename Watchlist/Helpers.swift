//
//  Helpers.swift
//  Watchlist
//
//  Created by TJ Carney on 12/31/18.
//  Copyright © 2018 TJ Carney. All rights reserved.
//

import Foundation

struct DateFormat {
    
    static func convertStringToDate(timeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: timeString)
    }
    
    static func getReadableDate(from date: String) -> String {
        let components = date.components(separatedBy: "-")
        let year = components[0]
        let month = components[1]
        let day = components[2]
        
        var displayMonth = ""
        
        switch  month {
        case "01":
            displayMonth = "January"
        case "02":
            displayMonth = "February"
        case "03":
            displayMonth = "March"
        case "04":
            displayMonth = "April"
        case "05":
            displayMonth = "May"
        case "06":
            displayMonth = "June"
        case "07":
            displayMonth = "July"
        case "08":
            displayMonth = "August"
        case "09":
            displayMonth = "September"
        case "10":
            displayMonth = "October"
        case "11":
            displayMonth = "November"
        case "12":
            displayMonth = "December"
        default:
            break
        }
        return "\(displayMonth) \(day), \(year)"
    }
    
}
