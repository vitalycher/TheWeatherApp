//
//  MainWeatherParameters.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class MainWeatherParameters: Decodable {
    var temp: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Float?
    var sea_level: Float?
    var grnd_level: Float?
    var humidity: Float?
}
