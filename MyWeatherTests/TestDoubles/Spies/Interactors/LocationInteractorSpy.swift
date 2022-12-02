//
//  LocationInteractorSpy.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

final class LocationInteractorSpy: LocationInteractor {
    
    var askedCities = [String]()
    var completions = [(Result<[AppCity], ApiError>) -> ()]()
    
    func fetchCities(cityName: String, completion: @escaping (Result<[AppCity], ApiError>) -> ()) {
        
        askedCities.append(cityName)
        completions.append(completion)
    }
}
