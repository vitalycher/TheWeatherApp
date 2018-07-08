//
//  DetailedForecastViewController.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 06.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import UIKit

class DetailedForecastViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var forecastDetailedFields = [ForecastDetailedField]()

    convenience init(weatherDetails: WeatherDetails) {
        self.init()

        configureDetailedFields(with: weatherDetails)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets.init(top: 30.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.register(UINib(nibName: "DetailedForecastTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "DetailedForecastTableViewCell")
    }

    @IBAction private func closeDetailsScreen(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func configureDetailedFields(with weatherDetails: WeatherDetails) {
        let generalParameters = weatherDetails.generalWeatherParameters

        let fields = [
            ForecastDetailedField(title: "In general".localized, description: weatherDetails.verbalDescriptionString),
            ForecastDetailedField(title: "Forecast date".localized, description: weatherDetails.convertedDateString),
            ForecastDetailedField(title: "Minimum temperature, °C".localized, description: generalParameters?.minimumTemperature?.intValue.toString),
            ForecastDetailedField(title: "Maximum temperature, °C".localized, description: generalParameters?.maximumTemperature?.intValue.toString),
            ForecastDetailedField(title: "Average temperature, °C".localized, description: generalParameters?.averageTemperature?.intValue.toString),
            ForecastDetailedField(title: "Humidity, %".localized, description: generalParameters?.humidity?.intValue.toString),
            ForecastDetailedField(title: "Cloud percentage, %".localized, description: weatherDetails.cloudPercentage?.cloudiness?.intValue.toString),
            ForecastDetailedField(title: "Average pressure, hPa".localized, description: generalParameters?.defaultPressure?.intValue.toString),
            ForecastDetailedField(title: "Sea level pressure, hPa".localized, description: generalParameters?.seaLevelAtmoPressure?.intValue.toString),
            ForecastDetailedField(title: "Ground level pressure, hPa".localized, description: generalParameters?.groundLevelAtmoPressure?.intValue.toString),
            ForecastDetailedField(title: "Wind speed, m/s".localized, description: weatherDetails.windDetails?.speed?.intValue.toString),
            ForecastDetailedField(title: "Wind direction, °".localized, description: weatherDetails.windDetails?.degrees?.intValue.toString)
        ]
        forecastDetailedFields = fields.filter { $0.description != nil }
    }

}

extension DetailedForecastViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDetailedFields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedForecastTableViewCell", for: indexPath) as! DetailedForecastTableViewCell
        cell.configure(with: forecastDetailedFields[indexPath.row])
        return cell
    }

}

extension DetailedForecastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

}
