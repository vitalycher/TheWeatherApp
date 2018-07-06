//
//  CloudPercentage.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class CloudPercentage: Decodable {
    var cloudiness: Double?
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}
