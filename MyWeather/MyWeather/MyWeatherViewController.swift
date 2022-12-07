//
//  ViewController.swift
//  MyWeather
//
//  Created by Victor Sousa on 05/11/2022.
//

import UIKit

protocol MyWeatherViewControllerPresenter {
    
    func loadWeather(location: AppCity,
                     completion: @escaping (Result<(CurrentWeatherCellConfiguration, [DailyWeatherCellConfiguration]), Error>) -> ())
}

protocol CitySearchResultView: UIViewController, UISearchResultsUpdating { }

final class MyWeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: MyWeatherViewControllerPresenter?
    var searchResultView: CitySearchResultView?
    
    private var searchController: UISearchController?
    private var currentConfig: CurrentWeatherCellConfiguration?
    private var dailyConfig: [DailyWeatherCellConfiguration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Weather"
        setupNavBar()
        setupSearchBar()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let london = AppCity(coordinate: .init(latitude: 51.5073219, longitude: -0.1276474),
                                          name: "London",
                                          state: "England",
                                          country: "GB")
        wantToShowWeather(city: london)
    }
    
    private func setupNavBar() {
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        let img = UIImage()
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .black
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "navColor")
        appearance.shadowImage = img
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
    
    private func setupSearchBar() {
        guard let resultScreen = searchResultView else { return }
        
        let searchController = UISearchController(searchResultsController: resultScreen)
        self.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = true
        
        searchController.searchBar.tintColor = UIColor(named: "cta")
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search",
                                                                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "cta") ?? UIColor.lightGray])
        searchController.searchBar.barStyle = UIBarStyle.black
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = .white

        searchController.searchResultsUpdater = resultScreen
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
//        definesPresentationContext = true
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension MyWeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyConfig.isEmpty ? 0 : dailyConfig.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "currentWeatherCell", for: indexPath) as? CurrentWeatherCell,
                    let currentConfig else { return defaultCell }
            cell.setup(config: currentConfig)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dailyWeatherCell", for: indexPath) as? DailyWeatherCell else { return defaultCell }
        cell.setup(config: dailyConfig[indexPath.row - 1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return .currentWeatherCellHeight
        }
        return .dailyWeatherCellHeight
    }
}

// MARK: SearchResultViewControllerDelegate

extension MyWeatherViewController: SearchResultViewControllerDelegate {
    
    func wantToShowWeather(city: AppCity) {
        presenter?.loadWeather(location: city, completion: { [weak self] result in
            
            guard let self else { return }
            switch result {
            case let .success((current, dailyWeathers)):
                
                self.searchController?.isActive = false
                self.currentConfig = current
                self.dailyConfig = dailyWeathers
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        })
    }
}

private extension CGFloat {
    
    static let currentWeatherCellHeight: CGFloat = 180
    static let dailyWeatherCellHeight: CGFloat = 96
}
