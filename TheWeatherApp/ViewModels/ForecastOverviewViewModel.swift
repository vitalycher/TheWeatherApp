//
//  ForecastOverviewViewModel.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 05.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import UIKit

struct ForecastOverviewViewModel: ForecastOverviewData {

    var date: String
    var verbalDescription: String
    var minumumTemperature: String
    var maximumTemperature: String
    var humidity: String
    var weatherIcon: UIImage

    init(_ weatherDetails: WeatherDetails?) {
        let undefinedValue = "Undefined".localized
        let weatherVerbalDescription = weatherDetails?.verbalDescriptionString ?? undefinedValue

        date = weatherDetails?.convertedDateString ?? undefinedValue
        verbalDescription = weatherVerbalDescription
        minumumTemperature = weatherDetails?.generalWeatherParameters?.minimumTemperature?.intValue.toString ?? undefinedValue
        maximumTemperature = weatherDetails?.generalWeatherParameters?.maximumTemperature?.intValue.toString ?? undefinedValue
        humidity = weatherDetails?.generalWeatherParameters?.humidity?.intValue.toString ?? undefinedValue

        switch weatherVerbalDescription {
        case "Clouds": weatherIcon = #imageLiteral(resourceName: "cloudy")
        case "Clear": weatherIcon = #imageLiteral(resourceName: "sunny")
        case "Rain": weatherIcon = #imageLiteral(resourceName: "rainy")
        default: weatherIcon = UIImage()
        }
    }

}
