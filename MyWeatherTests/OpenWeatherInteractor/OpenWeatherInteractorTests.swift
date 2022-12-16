//
//  OpenWeatherInteractorTests.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import XCTest
@testable import MyWeather

final class OpenWeatherInteractorTests: XCTestCase {
    
    func test_fetchWeather_validURL() async throws {
        
        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)
        let chicagoCoordinate = AppCity.chicago.coordinate
        clientSpy.getUrlStub = (.weatherResponse, nil)
        let _ = try await sut.fetchWeather(location: chicagoCoordinate)
        
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

    func test_fetchWeather_mapDailyWeatherOnCompletion() async throws {

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)
        clientSpy.getUrlStub = (.weatherResponse, nil)

        let (current, daily) = try await sut.fetchWeather(location: AppCity.chicago.coordinate)

        XCTAssertEqual(daily.count, 8)
        XCTAssertNotNil(current)
    }

    func test_fetchWeather_decodeErrorOnEmptyData() async throws {

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)
        clientSpy.getUrlStub = (Data(), nil)
        do {
            let _ = try await sut.fetchWeather(location: AppCity.chicago.coordinate)
            XCTFail("expecting failure")
        } catch let error as ApiError {
            XCTAssertEqual(error, .decodeError)
        }
    }

    func test_fetchWeather_apiErrorOnClientError() async throws{

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTWeather(client: clientSpy)

        clientSpy.getUrlStub = (Data(), ApiError.apiError)
        do {
            let _ = try await sut.fetchWeather(location: AppCity.chicago.coordinate)
            XCTFail("expecting failure")
        } catch let error as ApiError {
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
    
    func test_fetchCities_validURL() async throws{

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        clientSpy.getUrlStub = (.anyCityResponse, nil)
        
        let _ = try await sut.fetchCities(cityName: chicago.name)

        XCTAssertEqual(clientSpy.getURLs.count, 1)

        let received = clientSpy.getURLs[0]
        XCTAssertEqual(received.scheme, "https", "scheme")
        XCTAssertEqual(received.host, "api.openweathermap.org", "host")
        XCTAssertEqual(received.path, "/geo/1.0/direct", "path")
        XCTAssertEqual(received.query?.contains("q=\(chicago.name)"), true, "cityName")
        XCTAssertEqual(received.query?.contains("limit=5"), true, "limit response")
    }

    func test_fetchCities_mapAppCitiesOnCompletion() async throws {

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        clientSpy.getUrlStub = (.anyCityResponse, nil)

        let appCities = try await sut.fetchCities(cityName: chicago.name)

        XCTAssertTrue(appCities.contains(chicago))
        XCTAssertEqual(appCities.count, 5)
    }

    func test_fetchCities_decodeErrorOnEmptyData() async throws {

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        clientSpy.getUrlStub = (Data(), nil)

        do {
            let _ = try await sut.fetchCities(cityName: chicago.name)
        } catch let error as ApiError {
            
            XCTAssertEqual(error, .decodeError)
        }
    }

    func test_fetchCities_decodeErrorOnWrongData() async throws {

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        clientSpy.getUrlStub = (.weatherResponse, nil)

        do {
            let _ = try await sut.fetchCities(cityName: chicago.name)
        } catch let error as ApiError {
            
            XCTAssertEqual(error, .decodeError)
        }
    }

    func test_fetchCities_apiErrorOnClientError() async throws {

        let clientSpy = HTTPClientSpy()
        let sut = makeSUTLocation(client: clientSpy)
        let chicago = AppCity.chicago
        
        clientSpy.getUrlStub = (Data(), ApiError.apiError)
        do {
            let _ = try await sut.fetchCities(cityName: chicago.name)
            XCTFail("expecting failure")
        } catch let error as ApiError {
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
