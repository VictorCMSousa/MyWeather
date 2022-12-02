//
//  DailyWeatherCellConfiguration.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

extension DailyWeatherCellConfiguration {
    
    static let any = DailyWeatherCellConfiguration(date: "Today",
                                                   iconName: "wind",
                                                   condition: "wind",
                                                   maxTemp: "25C°",
                                                   minTemp: "18C°")
}
