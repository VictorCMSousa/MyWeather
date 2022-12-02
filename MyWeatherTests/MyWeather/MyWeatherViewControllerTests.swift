//
//  MyWeatherViewControllerTests.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import XCTest
@testable import MyWeather

final class MyWeatherViewControllerTests: XCTestCase {
    
    func test_viewLoad_updateTitle() {
        
        let sut = makeSUT()
        
        XCTAssertEqual(sut.title, "My Weather")
    }
    
    func test_viewLoad_askPresenterForWeather() {
        
        let presenterSpy = MyWeatherViewControllerPresenterSpy()
        let _ = makeSUT(presenter: presenterSpy)
        let london: AppCity = .london
        
        XCTAssertEqual(presenterSpy.requestedLocations, [london])
    }
    
    func test_wantToShowWeather_askPresenterForWeather() {
        
        let presenterSpy = MyWeatherViewControllerPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy)
        let london: AppCity = .london
        let chicago: AppCity = .chicago
        
        sut.wantToShowWeather(city: chicago)
        
        XCTAssertEqual(presenterSpy.requestedLocations, [london, chicago])
    }
    
    func test_wantToShowWeather_displayWeatherAfterCompletion() {
        
        let presenterSpy = MyWeatherViewControllerPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy)
        let city: AppCity = .chicago
        sut.wantToShowWeather(city: city)
        
        presenterSpy.completions[0]((.any, [.any, .any]))
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
        
        sut.wantToShowWeather(city: city)
        
        presenterSpy.completions[1]((.any, [.any]))
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_wantToShowWeather_verifyCellAfterCompletion() {
        
        let presenterSpy = MyWeatherViewControllerPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy)
        let city: AppCity = .chicago
        sut.wantToShowWeather(city: city)
        
        presenterSpy.completions[0]((.any, [.any, .any]))
        
        let currentWeatherCell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CurrentWeatherCell
        let dailyCell = sut.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DailyWeatherCell
        XCTAssertNotNil(currentWeatherCell)
        XCTAssertNotNil(dailyCell)
    }
    
    func makeSUT(presenter: MyWeatherViewControllerPresenter = MyWeatherViewControllerPresenterSpy(),
                 searchResultSpy: CitySearchResultView = CitySearchResultViewSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> MyWeatherViewController {
        
        let sut = UIStoryboard(name: "MyWeather", bundle: nil).instantiateInitialViewController() as! MyWeatherViewController
        sut.presenter = presenter
        sut.searchResultView = searchResultSpy
        sut.view.layoutIfNeeded()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
