//
//  MyWeatherTests.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 05/11/2022.
//

import XCTest
@testable import MyWeather

final class MyWeatherPresenterTests: XCTestCase {

    func test_loadWeather_askForWeather() {
        
        let weatherInteractorSpy = WeatherInteractorSpy()
        let sut = makeSUT(weatherInteractor: weatherInteractorSpy)
        let city = AppCity.chicago
        
        sut.loadWeather(location: city, completion: { (_, _) in })
        
        XCTAssertEqual(weatherInteractorSpy.askedCoordinates, [city.coordinate])
    }
    
    func test_loadWeather_completeWithWeather() {
        
        let weatherInteractorSpy = WeatherInteractorSpy()
        let sut = makeSUT(weatherInteractor: weatherInteractorSpy)
        let city = AppCity.chicago
        let weather = DailyWeather.anyWeather
        let currentConfig = CurrentWeatherCellConfiguration(cityName: city.name,
                                                            iconName: weather.weather.iconName,
                                                            condition: weather.weather.conditionName,
                                                            currentTemp: "\(weather.currentTemp!) C°",
                                                            maxTemp: "\(weather.maxTemp!) C°",
                                                            minTemp: "\(weather.minTemp!) C°")
        
        let dailyConfig = DailyWeatherCellConfiguration(date: weather.timestamp.formatted(date: .numeric, time: .omitted),
                                                        iconName: weather.weather.iconName,
                                                        condition: weather.weather.conditionName,
                                                        maxTemp: "\(weather.maxTemp!) C°",
                                                        minTemp: "\(weather.minTemp!) C°")
        
        var capturedResult: (CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration])?
        
        sut.loadWeather(location: city, completion: { (currentConfig, dailyConfigs) in
            capturedResult = (currentConfig, dailyConfigs)
        })
        
        weatherInteractorSpy.completions[0](.success((.anyWeather, [.anyWeather, .anyWeather])))
        
        XCTAssertEqual(capturedResult!.0, currentConfig)
        XCTAssertEqual(capturedResult!.1, [dailyConfig, dailyConfig])
    }
    
    func test_searchCity_askForCity() {
        let locationInteractorSpy = LocationInteractorSpy()
        let sut = makeSUT(locationInteractor: locationInteractorSpy)
        let city = AppCity.chicago
        
        sut.search(cityName: city.name, completion: { _ in })
        
        XCTAssertEqual(locationInteractorSpy.askedCities, [city.name])
    }
    
    func test_searchCity_completeWithCity() {
        let locationInteractorSpy = LocationInteractorSpy()
        let sut = makeSUT(locationInteractor: locationInteractorSpy)
        let city = AppCity.chicago
        var captureResult = [AppCity]()
        
        sut.search(cityName: city.name, completion: { cities in
            captureResult.append(contentsOf: cities)
        })
        
        locationInteractorSpy.completions[0](.success([city]))
        
        XCTAssertEqual(captureResult, [city])
    }
    
// MARK: Helpers
    
    func makeSUT(locationInteractor: LocationInteractor = LocationInteractorSpy(),
                 weatherInteractor: WeatherInteractor = WeatherInteractorSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> MyWeatherPresenter {
        
        let sut = MyWeatherPresenter(locationInteractor: locationInteractor,
                                     weatherInteractor: weatherInteractor)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
