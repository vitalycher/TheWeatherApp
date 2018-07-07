//
//  BinaryFloatingPoint+StringRepresentation.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 07.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

extension BinaryFloatingPoint {

    var toString: String {
        return String(Int(self))
    }

}
