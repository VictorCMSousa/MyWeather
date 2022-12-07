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
    
    var fetchCitiesStub: (response: [AppCity], error: Error?)? = nil
    func fetchCities(cityName: String) async throws -> [AppCity] {
        
        askedCities.append(cityName)
        
        guard let stub = fetchCitiesStub else { throw NSError(domain: "Need to set a stub", code: 0) }
        
        if let error = stub.error {
            
            throw error
        }
        return stub.response
    }
}
