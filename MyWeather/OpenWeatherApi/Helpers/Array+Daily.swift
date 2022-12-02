//
//  Array+Daily.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

extension Array where Element == Daily {
    
    func findTodayDaily() -> Daily? {
        self.first(where: { daily in
            let dailyDate = Date(timeIntervalSince1970: Double(daily.dt))
            return Calendar.current.isDateInToday(dailyDate)
        })
    }
}
