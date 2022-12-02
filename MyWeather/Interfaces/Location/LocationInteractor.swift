//
//  LocationInteractor.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

protocol LocationInteractor {
    
    func fetchCities(cityName: String, completion: @escaping (Result<[AppCity], ApiError>) -> ())
}
