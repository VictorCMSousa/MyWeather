//
//  CurrentWeatherCellConfiguration.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

extension CurrentWeatherCellConfiguration {
    
    static let any = CurrentWeatherCellConfiguration(cityName: AppCity.chicago.name,
                                                     iconName: "wind",
                                                     condition: "wind",
                                                     currentTemp: "20C°",
                                                     maxTemp: "22C°",
                                                     minTemp: "5C°")
}
