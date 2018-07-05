//
//  VerbalWeatherDescription.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class VerbalWeatherDescription: Decodable {
    var headline: String?
    
    enum CodingKeys: String, CodingKey {
        case headline = "main"
    }
}
