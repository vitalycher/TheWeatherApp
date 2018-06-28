//
//  Requests.swift
//  111Secuirty
//
//  Created by Vitaly Chernysh on 1/26/18.
//  Copyright © 2018 Egor Bozko. All rights reserved.
//

import Foundation

struct Requests {
    static func makeWeatherRequest(withParameters parameters: [String : Any]) -> Request<Forecast> {
        return Request<Forecast>(jsonUrlString: "http://api.openweathermap.org/data/2.5/forecast", method: .get, parameters: parameters, header: nil)
    }
}
