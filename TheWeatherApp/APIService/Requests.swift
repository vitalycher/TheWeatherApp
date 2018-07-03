//
//  Requests.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 02.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

struct Requests {
    static func makeWeatherRequest(withParameters parameters: [String : Any]) -> Request<Forecast> {
        return Request<Forecast>(jsonUrlString: "http://api.openweathermap.org/data/2.5/forecast", method: .get, parameters: parameters, header: nil)
    }
}
