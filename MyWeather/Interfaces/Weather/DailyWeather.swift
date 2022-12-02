//
//  WeatherModels.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

struct DailyWeather: Equatable {
    
    let timestamp: Date
    let currentTemp: Double?
    let maxTemp, minTemp: Double?
    let feelsLike: Double?
    let pressure, humidity: Int
    let uvi, dewPoint: Double
    let clouds: Int
    let visibility: Int?
    let windSpeed: Double
    let windDeg: Int
    let weather: WeatherCondition
    
    enum WeatherCondition: String {
        case fewClouds, clouds, clear, tornado, squall, ash, dust
        case sand, fog, haze, smoke, mist, snow
        case lightRain, rain, heavyRain, drizzle, thunderstorm
        case unknown
        
        
        var iconName: String {
            
            switch self {
            
            case .fewClouds: return "cloud.sun.fill"
            case .clouds: return "cloud.fill"
            case .clear: return "sun.max.fill"
            case .tornado: return "tornado"
            case .squall: return "wind"
            case .ash, .smoke: return "smoke.fill"
            case .dust, .sand: return "sun.dust.fill"
            case .fog, .haze, .mist: return "cloud.fog.fill"
            case .snow: return "snowflake"
            case .lightRain: return "cloud.sun.rain.fill"
            case .rain: return "cloud.rain.fill"
            case .heavyRain: return "cloud.heavyrain.fill"
            case .drizzle: return "cloud.drizzle.fill"
            case .thunderstorm: return "cloud.bolt.rain.fill"
            case .unknown: return "questionmark.diamond.fill"
            }
        }
        
        var conditionName: String {
            
            switch self {
            case .fewClouds: return "Partly Cloudy"
            case .clouds: return "Clouds"
            case .clear: return "Clear"
            case .tornado: return "Tornado"
            case .squall: return "Squall"
            case .smoke: return "Smoke"
            case .ash: return "Ash"
            case .dust, .sand: return "Dust"
            case .fog, .haze, .mist: return "Fog"
            case .snow: return "Snow"
            case .lightRain: return "Light Rain"
            case .rain: return "Rain"
            case .heavyRain: return "Heavy Rain"
            case .drizzle: return "Drizzle"
            case .thunderstorm: return "Thunderstorm"
            case .unknown: return "Unknown"
            }
        }
    }
}
