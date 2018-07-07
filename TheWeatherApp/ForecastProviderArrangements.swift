//
//  ForecastProviderArrangements.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 04.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

struct ForecastProviderArrangements {
    static let baseURL = "http://api.openweathermap.org/data/2.5/forecast"
    static let accessKey = "02d119c82f4e09478c5d4583a67d25aa"
    static let minimumDaysForecast = 1
    static let maximumDaysForecast = 5
    static let celsiusFormat = "metric"
    static let incomingDateFormat = "yyyy-MM-dd HH:mm:ss"
}
