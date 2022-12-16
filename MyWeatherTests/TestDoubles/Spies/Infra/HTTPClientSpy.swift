//
//  HTTPClientSpy.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

final class HTTPClientSpy: HTTPClient {
    
    var getURLs = [URL]()
    var completions = [(Result<Data, ApiError>) -> ()]()
    
    func get(url: URL, completion: @escaping (Result<Data, ApiError>) -> ()) {
        
        getURLs.append(url)
        completions.append(completion)
    }
    
    var getUrlStub: (data: Data, error: Error?) = (Data(), nil)
    func get(url: URL) async throws -> Data {
        getURLs.append(url)
        if let error = getUrlStub.error {
            throw error
        }
        return getUrlStub.data
    }
}
