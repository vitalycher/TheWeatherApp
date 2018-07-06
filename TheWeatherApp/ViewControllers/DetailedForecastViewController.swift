//
//  DetailedForecastViewController.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 06.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import UIKit

class DetailedForecastViewController: UIViewController {

    private var forecastDetailedFields = [ForecastDetailedField]() {
        didSet {
            print(forecastDetailedFields)
        }
    }

    var weatherDetails: WeatherDetails? {
        didSet {
            configureDetailedFields()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func configureDetailedFields() {
        func stringFromOptionalDoubleParameter(_ parameter: Double?) -> String? {
            if let exactValue = parameter {
                return String(Int(exactValue))
            } else {
                return nil
            }
        }

        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "EEEE, MMM d, HH:mm"

        let dateString = weatherDetails?.dateOfCalculation
        let convertedDateString: String?

        if let convertedDate = displayDateFormatter.date(from: dateString ?? "") {
            convertedDateString = displayDateFormatter.string(from: convertedDate)
        } else {
            convertedDateString = nil
        }

        forecastDetailedFields = [ForecastDetailedField(title: NSLocalizedString("Headline", comment: ""), description:
                                      weatherDetails?.verbalDescription?.first?.headline),
                                  ForecastDetailedField(title: NSLocalizedString("Forecast date", comment: ""), description: convertedDateString),
                                  ForecastDetailedField(title: NSLocalizedString("Minimum temperature", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.generalParameters?.minimumTemperature)),
                                  ForecastDetailedField(title: NSLocalizedString("Maximum temperature", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.generalParameters?.maximumTemperature)),
                                  ForecastDetailedField(title: NSLocalizedString("Average temperature", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.generalParameters?.averageTemperature)),
                                  ForecastDetailedField(title: NSLocalizedString("Humidity", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.generalParameters?.humidity)),
                                  ForecastDetailedField(title: NSLocalizedString("Cloud percentage", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.cloudPercentage?.cloudiness)),
                                  ForecastDetailedField(title: NSLocalizedString("Average pressure", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.generalParameters?.defaultPressure)),
                                  ForecastDetailedField(title: NSLocalizedString("Sea level pressure", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.generalParameters?.seaLevelAtmoPressure)),
                                  ForecastDetailedField(title: NSLocalizedString("Ground level pressure", comment: ""), description: stringFromOptionalDoubleParameter(weatherDetails?.generalParameters?.groundLevelAtmoPressure))]
    }

}
