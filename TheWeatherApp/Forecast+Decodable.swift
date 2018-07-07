//
//  Forecast+Decodable.swift
//  
//
//  Created by Vitaly Chernysh on 07.07.2018.
//

import Foundation

extension Forecast: Decodable {

    enum CodingKeys: String, CodingKey {
        case city
        case weatherDetails = "list"
    }
//   override init 
   
}
