//
//  DailyWeather.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

extension DailyWeather {
    
    static let anyWeather = DailyWeather(timestamp: Date(),
                                         currentTemp: 12,
                                         maxTemp: 20,
                                         minTemp: 10,
                                         feelsLike: 16,
                                         pressure: 1,
                                         humidity: 1,
                                         uvi: 1,
                                         dewPoint: 1,
                                         clouds: 1,
                                         visibility: 1,
                                         windSpeed: 1,
                                         windDeg: 1,
                                         weather: .mist)
    
}
