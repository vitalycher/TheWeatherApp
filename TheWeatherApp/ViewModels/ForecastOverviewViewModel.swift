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
        let weatherDescription = weatherDetails?.verbalDescription?.first?.headline ?? undefinedValue

        date = DisplayDateService.convertedString(from: weatherDetails?.dateOfCalculation) ?? undefinedValue
        verbalDescription = weatherDescription
        minumumTemperature = weatherDetails?.generalParameters?.minimumTemperature?.toInteger.toString ?? undefinedValue
        maximumTemperature = weatherDetails?.generalParameters?.maximumTemperature?.toInteger.toString ?? undefinedValue
        humidity = weatherDetails?.generalParameters?.humidity?.toInteger.toString ?? undefinedValue
        
        switch weatherDescription {
        case "Clouds": weatherIcon = #imageLiteral(resourceName: "cloudy")
        case "Clear": weatherIcon = #imageLiteral(resourceName: "sunny")
        case "Rain": weatherIcon = #imageLiteral(resourceName: "rainy")
        default: weatherIcon = UIImage()
        }
    }

}
