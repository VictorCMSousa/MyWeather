//
//  MyWeatherViewControllerPresenterSpy.swift
//  MyWeatherTests
//
//  Created by Victor Sousa on 07/11/2022.
//

import Foundation
@testable import MyWeather

final class MyWeatherViewControllerPresenterSpy: MyWeatherViewControllerPresenter {
    
    var requestedLocations = [AppCity]()
    var completionsConfigs = [((CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration])) -> ()]()
    
    func loadWeather(location: AppCity, completion: @escaping ((CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration])) -> ()) {
        
        requestedLocations.append(location)
        completionsConfigs.append(completion)
    }
    
    var completionsResults = [((Result<(CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration]), Error>)) -> ()]()
    func loadWeather(location: AppCity,
                     completion: @escaping (Result<(CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration]), Error>) -> ()) {
        
        requestedLocations.append(location)
        completionsResults.append(completion)
    }
}
