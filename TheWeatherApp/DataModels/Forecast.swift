//
//  Forecast.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

class Forecast: Decodable {
    var city: City?
    var weatherDetails: [WeatherDetails]?
    
    enum CodingKeys: String, CodingKey {
        case city
        case weatherDetails = "list"
    }
}
