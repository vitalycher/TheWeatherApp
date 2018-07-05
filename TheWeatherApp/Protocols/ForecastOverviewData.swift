//
//  ForecastOverviewData.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 05.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

protocol ForecastOverviewData {
    var date: String { get }
    var verbalDescription: String { get }
    var minumumTemperature: String { get }
    var maximumTemperature: String { get }
    var humidity: String { get }
}
