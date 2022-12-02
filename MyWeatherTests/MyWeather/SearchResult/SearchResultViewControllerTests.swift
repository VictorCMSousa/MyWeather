//
//  SearchResultViewControllerTests.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 10/11/2022.
//

import XCTest
@testable import MyWeather

final class SearchResultViewControllerTests: XCTestCase {
    
    func test_searchCity_askCityAppCity() {
        
        let presenterSpy = SearchResultViewControllerPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy)
        let searchController = UISearchController()
        searchController.searchBar.text = "Salvador"
        let exp = expectation(description: "waiting to perform request")
        
        sut.updateSearchResults(for: searchController)
        DispatchQueue.global().asyncAfter(deadline: .now().advanced(by: .milliseconds(600)),
                                          execute: { exp.fulfill() })
        
        wait(for: [exp], timeout: 0.8)
        XCTAssertEqual(presenterSpy.cityNames, ["Salvador"])
    }
    
    func makeSUT(presenter: SearchResultViewControllerPresenter = SearchResultViewControllerPresenterSpy(),
                 delegate: SearchResultViewControllerDelegate = SearchResultViewControllerDelegateSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> SearchResultViewController {
        
        let sut = SearchResultViewController()
        sut.presenter = presenter
        sut.delegate = delegate
        sut.view.layoutIfNeeded()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

final class SearchResultViewControllerPresenterSpy: SearchResultViewControllerPresenter {

    var cityNames = [String]()
    var completions = [([AppCity]) -> ()]()
    
    func search(cityName: String, completion: @escaping ([AppCity]) -> ()) {
        
        cityNames.append(cityName)
        completions.append(completion)
    }
}

final class SearchResultViewControllerDelegateSpy: SearchResultViewControllerDelegate {
    
    var wantToShowCities = [AppCity]()
    
    func wantToShowWeather(city: AppCity) {
        wantToShowCities.append(city)
    }
}
