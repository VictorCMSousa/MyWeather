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
    
    func loadWeather(location: AppCity, completion: @escaping ((CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration])) -> ()) {
        
        weatherInteractor.fetchWeather(location: location.coordinate) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success((currentWeather, dailyWeathers)):
                let currentWeatherConfig = self.map(cityName: location.name, currentWeather: currentWeather)
                let dailyConfig = dailyWeathers.map({ self.map(weather: $0) })
                completion((currentWeatherConfig, dailyConfig))
            case let .failure(error):
                print(error) // Should show to the user somehow and track the issue
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

    func search(cityName: String, completion: @escaping ([AppCity]) -> ()) {
        locationInteractor.fetchCities(cityName: cityName) { result in
            
            switch result {
            case let .success(cities):
                completion(cities)
            case let .failure(error):
                print(error) // Should show to the user somehow and track the issue
            }
        }
    }
}
