//
//  MyWeatherTests.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 05/11/2022.
//

import XCTest
@testable import MyWeather

final class MyWeatherPresenterTests: XCTestCase {

    func test_loadWeather_askForWeather() throws {
        
        let weatherInteractorSpy = WeatherInteractorSpy()
        let sut = makeSUT(weatherInteractor: weatherInteractorSpy)
        let city = AppCity.chicago
        
        let exp = expectation(description: "waiting completion")
        sut.loadWeather(location: city, completion: { _ in
            exp.fulfill()
        })
        wait(for: [exp], timeout: 0.1)
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

        var capturedResult: Result<(CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration]), Error>? = nil
        let exp = expectation(description: "waiting completion")

        weatherInteractorSpy.fetchWeatherStub = (response: (.anyWeather, [.anyWeather, .anyWeather]), error: nil)

        sut.loadWeather(location: city, completion: { result in
            capturedResult = result
            exp.fulfill()
        })

        wait(for: [exp], timeout: 0.3)
        switch capturedResult {
        case let .success((config, dailyConfigs)):

            XCTAssertEqual(config, currentConfig)
            XCTAssertEqual(dailyConfigs, [dailyConfig, dailyConfig])
        default:

            XCTFail("Completion must succeeded")
        }
    }
    
    func test_searchCity_askForCity() {
        let locationInteractorSpy = LocationInteractorSpy()
        let sut = makeSUT(locationInteractor: locationInteractorSpy)
        let city = AppCity.chicago
        let exp = expectation(description: "waiting completion")
        
        sut.search(cityName: city.name, completion: { _ in
            exp.fulfill()
        })
        wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(locationInteractorSpy.askedCities, [city.name])
    }
    
    func test_searchCity_completeWithCity() {
        
        let locationInteractorSpy = LocationInteractorSpy()
        let sut = makeSUT(locationInteractor: locationInteractorSpy)
        let city = AppCity.chicago
        var captureResult: Result<[AppCity], Error>? = nil
        let exp = expectation(description: "waiting completion")
        
        locationInteractorSpy.fetchCitiesStub = (response: [city], error: nil)
        sut.search(cityName: city.name, completion: { result in
            
            captureResult = result
            exp.fulfill()
        })
        wait(for: [exp], timeout: 0.3)
        switch captureResult {
        case let .success(captureCities):
            
            XCTAssertEqual(captureCities, [city])
        default:
            XCTFail("Completion must succeeded")
        }
        
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
