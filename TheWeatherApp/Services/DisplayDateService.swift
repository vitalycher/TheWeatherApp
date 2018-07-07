//
//  DisplayDateService.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 07.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

class DisplayDateService {
    static func convertedString(from incomingDateString: String?) -> String? {
        guard let incomingDateString = incomingDateString else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ForecastProviderArrangements.incomingDateFormat

        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "EEEE, MMM d, HH:mm"

        if let convertedDate = dateFormatter.date(from: incomingDateString) {
            return displayDateFormatter.string(from: convertedDate)
        } else {
            return nil
        }
    }
}
