//
//  OpenWeatherGeoModels.swift
//  MyWeather
//
//  Created by Victor Sousa on 06/11/2022.
//

import Foundation

// MARK: - WelcomeElement
struct OpenWeatherLocation: Codable {
    let name: String
    let lat, lon: Double
    let country: String
    let state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case lat, lon, country, state
    }
}
