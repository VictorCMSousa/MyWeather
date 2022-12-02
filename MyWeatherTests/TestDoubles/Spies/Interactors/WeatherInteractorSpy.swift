//
//  WeatherInteractorSpy.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

final class WeatherInteractorSpy: WeatherInteractor {
    
    var askedCoordinates = [AppCoordinate]()
    var completions = [(Result<(DailyWeather, [DailyWeather]), ApiError>) -> ()]()
    
    func fetchWeather(location: AppCoordinate, completion: @escaping (Result<(DailyWeather, [DailyWeather]), ApiError>) -> ()) {
        
        askedCoordinates.append(location)
        completions.append(completion)
    }
}
