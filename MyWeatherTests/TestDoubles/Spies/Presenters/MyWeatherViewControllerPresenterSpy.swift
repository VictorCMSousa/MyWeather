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
    var completions = [((CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration])) -> ()]()
    
    func loadWeather(location: AppCity, completion: @escaping ((CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration])) -> ()) {
        
        requestedLocations.append(location)
        completions.append(completion)
    }
}
