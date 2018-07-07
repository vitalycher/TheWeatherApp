//
//  Date+IsBetweenTwoDates.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 05.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

extension Date {
    func isBetween(_ leftDate: Date, and rightDate: Date) -> Bool {
        return (min(leftDate, rightDate) ... max(leftDate, rightDate)).contains(self)
    }
}
