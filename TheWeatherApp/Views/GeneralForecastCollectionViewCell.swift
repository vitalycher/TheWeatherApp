//
//  GeneralForecastCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 04.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import UIKit

class GeneralForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var verbalDescriptionLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var minimumTemperatureLabel: UILabel!
    @IBOutlet private weak var maximumTemperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var tapForDetailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 10.0
        tapForDetailsLabel.text = "Tap for details".localized
    }

    func configure(with dataProvider: ForecastOverviewData) {
        dateLabel.text = dataProvider.date
        verbalDescriptionLabel.text = dataProvider.verbalDescription
        minimumTemperatureLabel.text = "MIN TEMPERATURE \n".localized + dataProvider.minumumTemperature + "°C"
        maximumTemperatureLabel.text = "MAX TEMPERATURE \n".localized + dataProvider.maximumTemperature + "°C"
        humidityLabel.text = "HUMIDITY \n".localized + dataProvider.humidity + "%"
        weatherIconImageView.image = dataProvider.weatherIcon
    }

}
