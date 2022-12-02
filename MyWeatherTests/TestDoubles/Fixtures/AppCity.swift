//
//  AppCity.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

extension AppCity {

    static let chicago = AppCity(coordinate: .init(latitude: 41.8755616,
                                                   longitude: -87.6244212),
                                 name: "Chicago",
                                 state: "Illinois", country: "US")
    
    static let london = AppCity(coordinate: .init(latitude: 51.5073219, longitude: -0.1276474),
                                name: "London",
                                state: "England",
                                country: "GB")

}
