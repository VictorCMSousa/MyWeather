//
//  OpenWeatherClient.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import Foundation

final class OpenWeatherInteractor: WeatherInteractor {
    
    enum Units: String {
        case standard, metric, imperial
    }
    
    enum Parts: String {
        case current, minutely, hourly, daily, alerts
    }
    
    private let apiKey: String = {
        guard let filePath = Bundle.main.path(forResource: "OpenWeather-Info", ofType: "plist") else { return "" }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        return plist?.object(forKey: "API_KEY") as? String ?? ""
    }()
    
    private let baseURL = URL(string: "https://api.openweathermap.org")!
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        
        self.client = client
    }
    
    func fetchWeather(location: AppCoordinate) async throws -> (DailyWeather, [DailyWeather]) {
        guard let requestURL = makeGetWeatherURL(location: location) else { throw ApiError.invalidURLFormat }
        
        let data = try await client.get(url: requestURL)
        guard let root = try? JSONDecoder().decode(OpenWeatherRoot.self, from: data) else {
            
            throw ApiError.decodeError
        }
        let currentWeather = DailyWeather.map(current: root.current, dailyToday: root.daily.findTodayDaily())
        let dailyWeather = root.daily.map({ DailyWeather.map(daily: $0) })
        return (currentWeather, dailyWeather)
    }
}

extension OpenWeatherInteractor: LocationInteractor {

    func fetchCities(cityName: String) async throws -> [AppCity] {
        guard let requestURL = makeGetGeoCoordinateURL(cityName: cityName) else {
            throw ApiError.invalidURLFormat
        }
        let data = try await client.get(url: requestURL)
        guard let openLocation = try? JSONDecoder().decode([OpenWeatherLocation].self, from: data) else {
            
            throw ApiError.decodeError
        }
        return openLocation.map({ AppCity.map(weatherLocation: $0) })
    }
}

// MARK: Helpers

extension OpenWeatherInteractor {
    
    private func makeGetGeoCoordinateURL(cityName: String, limit: Int = 5) -> URL? {
        
        let geoRequest = baseURL.appendingPathComponent("geo/1.0/direct")
        guard !apiKey.isEmpty else { return nil }
        
        var componentURL = URLComponents(url: geoRequest, resolvingAgainstBaseURL: true)
        componentURL?.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "limit", value: String(5)),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        return componentURL?.url
    }
    
    private func makeGetWeatherURL(location: AppCoordinate,
                                            excludeParts: [Parts] = [.hourly, .minutely, .alerts],
                                            units: Units = .metric) -> URL? {

        let oneCallRequest = baseURL.appendingPathComponent("data/3.0/onecall")
        guard !apiKey.isEmpty else { return nil }
        
        var componentURL = URLComponents(url: oneCallRequest, resolvingAgainstBaseURL: true)
        
        componentURL?.queryItems = [
            URLQueryItem(name: "lat", value: String(location.latitude)),
            URLQueryItem(name: "lon", value: String(location.longitude)),
            URLQueryItem(name: "units", value: units.rawValue),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        let excludeList = makeExcludeList(from: excludeParts)
        if let excludeQuery = !excludeList.isEmpty ? URLQueryItem(name: "exclude", value: "hourly,minutely,alerts") : nil {
            
            componentURL?.queryItems?.append(excludeQuery)
        }
        return componentURL?.url
    }
    
    private func makeExcludeList(from excludeParts: [Parts]) -> String {
        excludeParts.enumerated().reduce("") { partialResult, partWithIndex in
            let (index, part) = partWithIndex
            let comma = index + 1 == excludeParts.count ? "" : ","
            return partialResult + part.rawValue + comma
        }
    }
}
