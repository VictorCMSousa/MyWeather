//
//  OpenWeatherInteractorTests.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import XCTest
@testable import MyWeather

final class OpenWeatherInteractorTests: XCTestCase {
    
    func test_fetchWeather_validURL() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)
        let chicagoCoordinate = AppCity.chicago.coordinate
        sut.fetchWeather(location: chicagoCoordinate, completion: { _ in })
        
        XCTAssertEqual(clientSpy.getURLs.count, 1)
        
        let received = clientSpy.getURLs[0]
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "api.openweathermap.org", "host")
        XCTAssertEqual(received.path, "/data/3.0/onecall", "path")
        XCTAssertEqual(received.query?.contains("lat=\(chicagoCoordinate.latitude)"), true, "latitude")
        XCTAssertEqual(received.query?.contains("lon=\(chicagoCoordinate.longitude)"), true, "longitude")
        XCTAssertEqual(received.query?.contains("exclude=hourly,minutely,alerts"), true, "kind excluded")
        XCTAssertEqual(received.query?.contains("units=metric"), true, "unit")
    }
    
    func test_fetchWeather_mapDailyWeatherOnCompletion() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)
        let expectation = expectation(description: "waiting completion")
        
        var capturedResult: Result<(DailyWeather, [DailyWeather]), ApiError> = .failure(.invalidURLFormat)
        sut.fetchWeather(location: AppCity.chicago.coordinate, completion: { result in
            capturedResult = result
            expectation.fulfill()
        })
        
        clientSpy.completions[0](.success(.weatherResponse))
        
        wait(for: [expectation], timeout: 0.5)
        switch capturedResult {
        case let .success((current, daily)):
            XCTAssertEqual(daily.count, 8)
            XCTAssertNotNil(current)
        case .failure(let error):
            XCTFail("expecting success got \(error)")
        }
    }
    
    func test_fetchWeather_decodeErrorOnEmptyData() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)
        let expectation = expectation(description: "waiting completion")
        
        var capturedResult: Result<(DailyWeather, [DailyWeather]), ApiError> = .failure(.invalidURLFormat)
        sut.fetchWeather(location: AppCity.chicago.coordinate, completion: { result in
            capturedResult = result
            expectation.fulfill()
        })
        
        clientSpy.completions[0](.success(Data()))
        
        wait(for: [expectation], timeout: 0.5)
        switch capturedResult {
        case .success:
            XCTFail("expecting failure")
        case .failure(let error):
            XCTAssertEqual(error, .decodeError)
        }
    }
    
    func test_fetchWeather_apiErrorOnClientError() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)
        let expectation = expectation(description: "waiting completion")
        
        var capturedResult: Result<(DailyWeather, [DailyWeather]), ApiError> = .failure(.invalidURLFormat)
        sut.fetchWeather(location: AppCity.chicago.coordinate, completion: { result in
            capturedResult = result
            expectation.fulfill()
        })
        
        clientSpy.completions[0](.failure(.apiError))
        
        wait(for: [expectation], timeout: 0.5)
        switch capturedResult {
        case .success:
            XCTFail("expecting failure")
        case .failure(let error):
            XCTAssertEqual(error, .apiError)
        }
    }
    
    func makeSUTWeather(client: HTTPClient = HTTPClientSpy(),
                        file: StaticString = #filePath,
                        line: UInt = #line) -> WeatherInteractor {
        
        let sut = OpenWeatherInteractor(client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

//    MARK: Location Interactor

extension OpenWeatherInteractorTests{
    
    func test_fetchCities_validURL() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        sut.fetchCities(cityName: chicago.name, completion: { _ in })
        
        XCTAssertEqual(clientSpy.getURLs.count, 1)
        
        let received = clientSpy.getURLs[0]
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "api.openweathermap.org", "host")
        XCTAssertEqual(received.path, "/geo/1.0/direct", "path")
        XCTAssertEqual(received.query?.contains("q=\(chicago.name)"), true, "cityName")
        XCTAssertEqual(received.query?.contains("limit=5"), true, "limit response")
    }
    
    func test_fetchCities_mapAppCitiesOnCompletion() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        let expectation = expectation(description: "waiting completion")
        
        var capturedResult:Result<[AppCity], ApiError> = .failure(.invalidURLFormat)
        sut.fetchCities(cityName: chicago.name, completion: { result in
            capturedResult = result
            expectation.fulfill()
        })
        
        clientSpy.completions[0](.success(.anyCityResponse))
        
        wait(for: [expectation], timeout: 0.5)
        switch capturedResult {
        case let .success(appCities):
            XCTAssertTrue(appCities.contains(chicago))
            XCTAssertEqual(appCities.count, 5)
        case .failure(let error):
            XCTFail("expecting success got \(error)")
        }
    }
    
    func test_fetchCities_decodeErrorOnEmptyData() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        let expectation = expectation(description: "waiting completion")
        
        var capturedResult:Result<[AppCity], ApiError> = .failure(.invalidURLFormat)
        sut.fetchCities(cityName: chicago.name, completion: { result in
            capturedResult = result
            expectation.fulfill()
        })
        
        clientSpy.completions[0](.success(Data()))
        
        wait(for: [expectation], timeout: 0.5)
        switch capturedResult {
        case .success:
            XCTFail("expecting failure")
        case .failure(let error):
            XCTAssertEqual(error, .decodeError)
        }
    }
    
    func test_fetchCities_decodeErrorOnWrongData() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        let expectation = expectation(description: "waiting completion")
        
        var capturedResult:Result<[AppCity], ApiError> = .failure(.invalidURLFormat)
        sut.fetchCities(cityName: chicago.name, completion: { result in
            capturedResult = result
            expectation.fulfill()
        })
        
        clientSpy.completions[0](.success(.weatherResponse))
        
        wait(for: [expectation], timeout: 0.5)
        switch capturedResult {
        case .success:
            XCTFail("expecting failure")
        case .failure(let error):
            XCTAssertEqual(error, .decodeError)
        }
    }
    
    func test_fetchCities_apiErrorOnClientError() {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        let expectation = expectation(description: "waiting completion")
        
        var capturedResult:Result<[AppCity], ApiError> = .failure(.invalidURLFormat)
        sut.fetchCities(cityName: chicago.name, completion: { result in
            capturedResult = result
            expectation.fulfill()
        })
        
        clientSpy.completions[0](.failure(.apiError))
        
        wait(for: [expectation], timeout: 0.5)
        switch capturedResult {
        case .success:
            XCTFail("expecting failure")
        case .failure(let error):
            XCTAssertEqual(error, .apiError)
        }
    }
    
    func makeSUTLocation(client: HTTPClient = HTTPClientSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> LocationInteractor {
        
        let sut = OpenWeatherInteractor(client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
