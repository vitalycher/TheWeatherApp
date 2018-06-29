//
//  MainWeatherParameters.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class MainWeatherParameters: Decodable {
    var averageTemperature: Double?
    var minimumTemperature: Double?
    var maximumTemperature: Double?
    var defaultPressure: Double?
    var seaLevelAtmoPressure: Double?
    var groundLevelAtmoPressure: Double?
    var humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case averageTemperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case defaultPressure = "pressure"
        case seaLevelAtmoPressure = "sea_level"
        case groundLevelAtmoPressure = "grnd_level"
        case humidity
    }
}
