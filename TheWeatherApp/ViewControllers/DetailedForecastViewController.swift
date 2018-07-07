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
        tableView.contentInset = UIEdgeInsets.init(top: 30.0, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: "DetailedForecastTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "DetailedForecastTableViewCell")
    }

    @IBAction private func closeDetailsScreen(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func configureDetailedFields(with weatherDetails: WeatherDetails) {
//        let convertedDateString = DisplayDateService.convertedString(from: weatherDetails.dateOfCalculation)
        
//        let fields = [
//            ForecastDetailedField(title: "Headline".localized, description:
//                weatherDetails.verbalDescription?.first?.headline),
//            ForecastDetailedField(title: "Forecast date".localized, description: convertedDateString),
//            ForecastDetailedField(title: "Minimum temperature, °C".localized, description: weatherDetails.generalParameters?.minimumTemperature?.toString)
//            ForecastDetailedField(title: NSLocalizedString("Maximum temperature, °C", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.maximumTemperature)),
//            ForecastDetailedField(title: NSLocalizedString("Average temperature, °C", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.averageTemperature)),
//            ForecastDetailedField(title: NSLocalizedString("Humidity, %", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.humidity)),
//            ForecastDetailedField(title: NSLocalizedString("Cloud percentage, %", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.cloudPercentage?.cloudiness)),
//            ForecastDetailedField(title: NSLocalizedString("Average pressure, hPa", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.defaultPressure)),
//            ForecastDetailedField(title: NSLocalizedString("Sea level pressure, hPa", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.seaLevelAtmoPressure)),
//            ForecastDetailedField(title: NSLocalizedString("Ground level pressure, hPa", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.groundLevelAtmoPressure))
//        ]
//        forecastDetailedFields = fields.filter { $0.description != nil }
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
