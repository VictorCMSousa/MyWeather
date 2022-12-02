//
//  DailyWeather+Mappers.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

extension DailyWeather {
    
    static func map(current: Current, dailyToday: Daily?) -> DailyWeather {
        .init(timestamp: Date(timeIntervalSince1970: Double(current.dt)),
              currentTemp: current.temp,
              maxTemp: dailyToday?.temp.max,
              minTemp: dailyToday?.temp.min,
              feelsLike: current.feelsLike,
              pressure: current.pressure,
              humidity: current.humidity,
              uvi: current.uvi,
              dewPoint: current.dewPoint,
              clouds: current.clouds,
              visibility: current.visibility,
              windSpeed: current.windSpeed,
              windDeg: current.windDeg,
              weather: map(weather: current.weather.first))
    }
    
    static func map(daily: Daily) -> DailyWeather {
        .init(timestamp: Date(timeIntervalSince1970: Double(daily.dt)),
              currentTemp: .none,
              maxTemp: daily.temp.max,
              minTemp: daily.temp.min,
              feelsLike: .none,
              pressure: daily.pressure,
              humidity: daily.humidity,
              uvi: daily.uvi,
              dewPoint: daily.dewPoint,
              clouds: daily.clouds,
              visibility: .none,
              windSpeed: daily.windSpeed,
              windDeg: daily.windDeg,
              weather: map(weather: daily.weather.first))
    }
    
    private static func map(weather: Weather?) -> DailyWeather.WeatherCondition {
        
        guard let weather = weather else { return .unknown }
        
        switch weather.id {
        case 200 ... 299:
            return .thunderstorm
        case 300 ... 399:
            return .drizzle
        case 500:
            return .lightRain
        case 501, 502:
            return .rain
        case 503 ..< 511:
            return .heavyRain
        case 511:
            return .snow
        case 520:
            return .lightRain
        case 521 ... 599:
            return .rain
        case 600 ... 699:
            return .snow
        case 701:
            return .mist
        case 711:
            return .smoke
        case 721:
            return .haze
        case 731, 761:
            return .dust
        case 741:
            return .fog
        case 751:
            return .sand
        case 762:
            return .ash
        case 771:
            return .squall
        case 781:
            return .tornado
        case 800:
            return .clear
        case 801:
            return .fewClouds
        case 802 ... 804:
            return .clouds
        default:
            return .unknown
        }
    }
}
