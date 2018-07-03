//
//  WeatherDetails.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class WeatherDetails: Decodable {
    var generalParameters: GeneralWeatherParameters?
    var verbalDescription: [VerbalWeatherDescription]?
    var cloudPercentage: CloudPercentage?
    var wind: WindDetails?
    var dateOfCalculation: String?
    
    enum CodingKeys: String, CodingKey {
        case generalParameters = "main"
        case verbalDescription = "weather"
        case cloudPercentage = "clouds"
        case wind
        case dateOfCalculation = "dt_txt"
    }
}
