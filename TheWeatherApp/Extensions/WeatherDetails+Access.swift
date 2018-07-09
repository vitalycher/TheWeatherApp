//
//  WeatherDetails+Access.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 08.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation

extension WeatherDetails {

    var verbalDescriptionString: String? {
        guard let verbalWeatherDescription = verbalWeatherDescription else { return nil }
        return (Array(verbalWeatherDescription) as? [VerbalWeatherDescription])?.first?.headline
    }

    var convertedDateString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ForecastProviderArrangements.incomingDateFormat
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "EEEE, d MMMM, HH:mm"
        
        if let convertedDate = dateFormatter.date(from: dateOfCalculation ?? "") {
            return displayDateFormatter.string(from: convertedDate)
        } else {
            return nil
        }
    }

}
