//
//  Forecast+CoreDataProperties.swift
//  
//
//  Created by Vitaly Chernysh on 07.07.2018.
//
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        return NSFetchRequest<Forecast>(entityName: "Forecast")
    }

    @NSManaged public var city: City?
    @NSManaged public var weatherDetails: NSSet?

}

// MARK: Generated accessors for weatherDetails
extension Forecast {

    @objc(addWeatherDetailsObject:)
    @NSManaged public func addToWeatherDetails(_ value: WeatherDetails)

    @objc(removeWeatherDetailsObject:)
    @NSManaged public func removeFromWeatherDetails(_ value: WeatherDetails)

    @objc(addWeatherDetails:)
    @NSManaged public func addToWeatherDetails(_ values: NSSet)

    @objc(removeWeatherDetails:)
    @NSManaged public func removeFromWeatherDetails(_ values: NSSet)

}
