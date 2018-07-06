//
//  DetailedForecastTableViewCell.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 07.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import UIKit

class DetailedForecastTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    func configure(with detailedForecast: ForecastDetailedField) {
        titleLabel.text = detailedForecast.title
        descriptionLabel.text = detailedForecast.description
    }

}
