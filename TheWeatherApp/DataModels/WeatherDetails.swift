//
//  WeatherDetails.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class WeatherDetails: Decodable {
    var main: MainWeatherParameters?
    var weather: [VerbalWeatherDescription]?
    var clouds: CloudPercentage?
    var wind: WindDetails?
    var dt_txt: String?
}
