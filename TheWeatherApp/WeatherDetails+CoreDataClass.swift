//
//  WeatherDetails+CoreDataClass.swift
//  
//
//  Created by Vitaly Chernysh on 07.07.2018.
//
//

import Foundation
import CoreData

@objc(WeatherDetails)
public class WeatherDetails: NSManagedObject {
        var generalParameters: GeneralWeatherParameters?
        var verbalDescription: [VerbalWeatherDescription]?
        var cloudPercentage: CloudPercentage?
        var wind: WindDetails?
        var dateOfCalculation: String?
}
