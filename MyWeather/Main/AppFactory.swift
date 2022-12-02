//
//  AppFactory.swift
//  MyWeather
//
//  Created by Victor Sousa on 07/11/2022.
//

import UIKit

final class AppFactory {
    
    private static let appSession = URLSession(configuration: .default)
    private static let networkClient = NetworkClient(session: appSession)
    private static let openWeatherInteractor = OpenWeatherInteractor(client: networkClient)
    
    static func makeWeatherView() -> MyWeatherViewController? {
        
        let presenter = MyWeatherPresenter(locationInteractor: openWeatherInteractor,
                                           weatherInteractor: openWeatherInteractor)
        
        let myWeatherViewControler = UIStoryboard(name: "MyWeather", bundle: nil).instantiateInitialViewController() as? MyWeatherViewController
        myWeatherViewControler?.presenter = presenter
        
        let searchResultViewController = SearchResultViewController()
        searchResultViewController.delegate = myWeatherViewControler
        searchResultViewController.presenter = presenter
        
        myWeatherViewControler?.searchResultView = searchResultViewController
        
        return myWeatherViewControler
    }
}
