//
//  CurrentWeatherCell.swift
//  MyWeather
//
//  Created by Victor Sousa on 06/11/2022.
//

import UIKit

struct CurrentWeatherCellConfiguration: Equatable {
    
    let cityName: String
    let iconName: String
    let condition: String
    let currentTemp: String
    let maxTemp: String
    let minTemp: String
}

final class CurrentWeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func setup(config: CurrentWeatherCellConfiguration) {
        
        cityNameLabel.text = config.cityName
        iconImageView.image = UIImage(systemName: config.iconName)
        conditionLabel.text = config.condition
        currentTempLabel.text = config.currentTemp
        maxTempLabel.text = "Max: \(config.maxTemp)"
        minTempLabel.text = "Min: \(config.minTemp)"
    }
}
