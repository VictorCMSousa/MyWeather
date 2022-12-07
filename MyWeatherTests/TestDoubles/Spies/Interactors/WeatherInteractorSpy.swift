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
    
    var fetchWeatherStub: (response: (DailyWeather, [DailyWeather]), error: Error?)? = nil
    func fetchWeather(location: AppCoordinate) async throws -> (DailyWeather, [DailyWeather]) {
        
        askedCoordinates.append(location)
        guard let stub = fetchWeatherStub else { throw NSError(domain: "Need to set a stub", code: 0) }
        
        if let error = stub.error {
            
            throw error
        }
        return stub.response
    }
}
