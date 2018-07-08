//
//  Double+NSNumberConversion.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 08.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

extension Double {

    func toNSNumber() -> NSNumber {
        return NSNumber(value: self)
    }

}
