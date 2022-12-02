//
//  AppCoordinate.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

struct AppCity: Equatable {
    
    let coordinate: AppCoordinate
    let name: String
    let state: String?
    let country: String
}

struct AppCoordinate: Equatable {
    
    let latitude: Double
    let longitude: Double
}
