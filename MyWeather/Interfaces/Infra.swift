//
//  Infra.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

protocol AppSession {
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> AppSessionDataTask
}

protocol AppSessionDataTask {
    
    func resume()
}

extension URLSession: AppSession {
    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> AppSessionDataTask {
        let task: URLSessionDataTask = self.dataTask(with: url, completionHandler: completionHandler)
        return task
    }
}
extension URLSessionDataTask: AppSessionDataTask {}

protocol HTTPClient {
    
//    In case of using Async await that was released - Swift 5.5. But I'll use the "old way"
//    func get(url: URL) async throws -> Data
    func get(url: URL, completion: @escaping (Result<Data, ApiError>) -> ())
}

enum ApiError: String, Error {
    
    case invalidResponse
    case decodeError
    case apiError
    case invalidURLFormat
}

final class NetworkClient: HTTPClient {
    
    private let session: AppSession
    
    init(session: AppSession) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping (Result<Data, ApiError>) -> ()) {
        
        session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(ApiError.apiError))
                return
            }
            guard let response = response, let data = data else {
                completion(.failure(ApiError.apiError))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
