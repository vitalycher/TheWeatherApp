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
        tableView.register(UINib(nibName: "DetailedForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailedForecastTableViewCell")
    }

    @IBAction private func closeDetailsScreen(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func configureDetailedFields(with weatherDetails: WeatherDetails) {
        func stringFromOptionalDoubleParameter(_ parameter: Double?) -> String? {
            if let exactValue = parameter {
                return String(Int(exactValue))
            } else {
                return nil
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "EEEE, MMM d, HH:mm"

        let dateString = weatherDetails.dateOfCalculation
        let convertedDateString: String?

        if let convertedDate = dateFormatter.date(from: dateString ?? "") {
            convertedDateString = displayDateFormatter.string(from: convertedDate)
        } else {
            convertedDateString = nil
        }

        let fields = [ForecastDetailedField(title: NSLocalizedString("Headline", comment: ""), description:
            weatherDetails.verbalDescription?.first?.headline),
                                  ForecastDetailedField(title: NSLocalizedString("Forecast date", comment: ""), description: convertedDateString),
                                  ForecastDetailedField(title: NSLocalizedString("Minimum temperature, °C", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.minimumTemperature)),
                                  ForecastDetailedField(title: NSLocalizedString("Maximum temperature, °C", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.maximumTemperature)),
                                  ForecastDetailedField(title: NSLocalizedString("Average temperature, °C", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.averageTemperature)),
                                  ForecastDetailedField(title: NSLocalizedString("Humidity, %", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.humidity)),
                                  ForecastDetailedField(title: NSLocalizedString("Cloud percentage, %", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.cloudPercentage?.cloudiness)),
                                  ForecastDetailedField(title: NSLocalizedString("Average pressure, hPa", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.defaultPressure)),
                                  ForecastDetailedField(title: NSLocalizedString("Sea level pressure, hPa", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.seaLevelAtmoPressure)),
                                  ForecastDetailedField(title: NSLocalizedString("Ground level pressure, hPa", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails.generalParameters?.groundLevelAtmoPressure))]
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
