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
    @IBOutlet weak var tapForDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 10.0
        tapForDetailsLabel.text = NSLocalizedString("Tap for details", comment: "")
    }
    
    func configure(with dataProvider: ForecastOverviewData) {
        dateLabel.text = dataProvider.date
        verbalDescriptionLabel.text = dataProvider.verbalDescription
        minimumTemperatureLabel.text = NSLocalizedString("MIN TEMPERATURE \n", comment: "") + dataProvider.minumumTemperature + "°C"
        maximumTemperatureLabel.text = NSLocalizedString("MAX TEMPERATURE \n", comment: "") + dataProvider.maximumTemperature + "°C"
        humidityLabel.text = NSLocalizedString("HUMIDITY \n", comment: "") + dataProvider.humidity + "%"
        weatherIconImageView.image = dataProvider.weatherIcon
    }

}
