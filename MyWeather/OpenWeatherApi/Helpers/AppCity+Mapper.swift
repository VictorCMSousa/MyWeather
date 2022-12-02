//
//  AppCity+Mapper.swift
//  MyWeather
//
//  Created by Victor Sousa on 06/11/2022.
//

import Foundation

extension AppCity {
    
    static func map(weatherLocation: OpenWeatherLocation) -> AppCity {
        .init(coordinate: .init(latitude: weatherLocation.lat,
                                longitude: weatherLocation.lon),
              name: weatherLocation.name,
              state: weatherLocation.state,
              country: weatherLocation.country)
    }
}
