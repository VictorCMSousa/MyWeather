//
//  WeatherInteractor.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

protocol WeatherInteractor {
    
    func fetchWeather(location: AppCoordinate, completion: @escaping (Result<(DailyWeather, [DailyWeather]), ApiError>)->())
}
