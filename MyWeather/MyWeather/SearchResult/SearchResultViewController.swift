//
//  SearchResultViewController.swift
//  MyWeather
//
//  Created by Victor Sousa on 07/11/2022.
//

import UIKit

protocol SearchResultViewControllerPresenter {
    
    func search(cityName: String, completion: @escaping (Result<[AppCity], Error>) -> ())
}

protocol SearchResultViewControllerDelegate: AnyObject {
    
    func wantToShowWeather(city: AppCity)
}

final class SearchResultViewController: UITableViewController, CitySearchResultView {
    
    var presenter: SearchResultViewControllerPresenter?
    
    private let cellIdentifier = "cell"
    private var cities: [AppCity] = []
    weak var delegate: SearchResultViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let city = cities[indexPath.row]
        content.text = "\(city.name) \(city.state ?? "") \(city.country)"
        cell.contentConfiguration = content
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        delegate?.wantToShowWeather(city: city)
//        cityWasSelected?(city)
        dismiss(animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(filterContentForSearchText(searchController:)), object: searchController)
        self.perform(#selector(filterContentForSearchText(searchController:)), with: searchController, afterDelay: 0.5)
    }
    
    @objc private func filterContentForSearchText(searchController: UISearchController) {
        guard let cityName = searchController.searchBar.text, !cityName.isEmpty else { return }
        presenter?.search(cityName: cityName, completion: { [weak self] result in
            
            switch result {
            case let .success(cities):
                self?.cities = cities
                self?.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        })
    }
}
