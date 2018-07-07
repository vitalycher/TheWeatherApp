//
//  WeatherDetails+CoreDataProperties.swift
//  
//
//  Created by Vitaly Chernysh on 07.07.2018.
//
//

import Foundation
import CoreData


extension WeatherDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDetails> {
        return NSFetchRequest<WeatherDetails>(entityName: "WeatherDetails")
    }

    @NSManaged public var forecast: Forecast?

}
