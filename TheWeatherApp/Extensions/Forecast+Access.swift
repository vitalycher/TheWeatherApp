//
//  Forecast+Access.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 08.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

extension Forecast {

    var sortedWeatherDetails: [WeatherDetails] {
        guard
            let weatherDetailsSet = weatherDetails,
            let weatherDetailsArray = Array(weatherDetailsSet) as? [WeatherDetails]
        else {
            return []
        }
        return weatherDetailsArray.sorted { $0.dateOfCalculation ?? "" < $1.dateOfCalculation ?? "" }
    }

}
