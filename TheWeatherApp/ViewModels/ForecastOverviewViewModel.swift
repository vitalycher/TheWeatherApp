//
//  ForecastOverviewViewModel.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 05.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

struct ForecastOverviewViewModel: ForecastOverviewData {
    var date: String
    var verbalDescription: String
    var minumumTemperature: String
    var maximumTemperature: String
    var humidity: String
    
    init(_ weatherDetails: WeatherDetails?) {
        let undefinedValue = NSLocalizedString("Undefined", comment: "")
        date = weatherDetails?.dateOfCalculation ?? undefinedValue
        verbalDescription = weatherDetails?.verbalDescription?.first?.headline ?? undefinedValue
        minumumTemperature = String(weatherDetails?.generalParameters?.minimumTemperature ?? 0.0)
        maximumTemperature = String(weatherDetails?.generalParameters?.maximumTemperature ?? 0.0)
        humidity = String(weatherDetails?.generalParameters?.humidity ?? 0.0)
    }
}
