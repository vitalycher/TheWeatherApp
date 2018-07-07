//
//  Forecast+Decoding.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 07.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

extension Forecast {

    enum CodingKeys: String, CodingKey {
        case city
        case weatherDetails = "list"
    }

}
