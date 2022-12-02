//
//  DailyWeatherCell.swift
//  MyWeather
//
//  Created by Victor Sousa on 06/11/2022.
//

import UIKit

struct DailyWeatherCellConfiguration: Equatable {
    
    let date: String
    let iconName: String
    let condition: String
    let maxTemp: String
    let minTemp: String
}

final class DailyWeatherCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func setup(config: DailyWeatherCellConfiguration) {
        
        dateLabel.text = config.date
        iconImageView.image = UIImage(systemName: config.iconName)
        conditionLabel.text = config.condition
        maxTempLabel.text = "Max: \(config.maxTemp)"
        minTempLabel.text = "Min: \(config.minTemp)"
    }
}
