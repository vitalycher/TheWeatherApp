//
//  WindDetails.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class WindDetails: Decodable {

    var speed: Double?
    var degrees: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }

}
