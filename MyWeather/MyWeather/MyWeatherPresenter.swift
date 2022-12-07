//
//  MyWeatherPresenter.swift
//  MyWeather
//
//  Created by Victor Sousa on 06/11/2022.
//

import Foundation

final class MyWeatherPresenter {
    
    private let locationInteractor: LocationInteractor
    private let weatherInteractor: WeatherInteractor
    
    init(locationInteractor: LocationInteractor, weatherInteractor: WeatherInteractor) {
        self.locationInteractor = locationInteractor
        self.weatherInteractor = weatherInteractor
    }
}

// MARK: MyWeatherViewControlerPresenter

extension MyWeatherPresenter: MyWeatherViewControllerPresenter {
    
    func loadWeather(location: AppCity,
                     completion: @escaping (Result<(CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration]), Error>) -> ()) {
        
        Task {
            do {
                
                let (currentWeather, dailyWeathers) = try await weatherInteractor.fetchWeather(location: location.coordinate)
                let currentWeatherConfig = self.map(cityName: location.name, currentWeather: currentWeather)
                let dailyConfig = dailyWeathers.map({ self.map(weather: $0) })
                DispatchQueue.main.async {
                    completion(.success((currentWeatherConfig, dailyConfig)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func map(cityName: String, currentWeather: DailyWeather) -> CurrentWeatherCellConfiguration {
        
        let currentTemp = currentWeather.currentTemp != nil ? String(describing: currentWeather.currentTemp ?? 0) : "-"
        let maxTemp = currentWeather.maxTemp != nil ? String(describing: currentWeather.maxTemp ?? 0) : "-"
        let minTemp = currentWeather.minTemp != nil ? String(describing: currentWeather.minTemp ?? 0) : "-"
        return CurrentWeatherCellConfiguration(cityName: cityName,
                                               iconName: currentWeather.weather.iconName,
                                               condition: currentWeather.weather.conditionName,
                                               currentTemp: "\(currentTemp) C°" ,
                                               maxTemp: "\(maxTemp) C°",
                                               minTemp: "\(minTemp) C°")
    }
    
    private func map(weather: DailyWeather) -> DailyWeatherCellConfiguration {
        
        let maxTemp = weather.maxTemp != nil ? String(describing: weather.maxTemp ?? 0) : "-"
        let minTemp = weather.minTemp != nil ? String(describing: weather.minTemp ?? 0) : "-"
        return DailyWeatherCellConfiguration(date: weather.timestamp.formatted(date: .numeric, time: .omitted),
                                             iconName: weather.weather.iconName,
                                             condition: weather.weather.conditionName,
                                             maxTemp: "\(maxTemp) C°",
                                             minTemp: "\(minTemp) C°")
    }
}

extension MyWeatherPresenter: SearchResultViewControllerPresenter {

    func search(cityName: String, completion: @escaping (Result<[AppCity], Error>) -> ()) {
        
        Task {
            do {
                let cities = try await locationInteractor.fetchCities(cityName: cityName)
                DispatchQueue.main.async {
                    completion(.success(cities))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
