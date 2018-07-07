//
//  City+CoreDataProperties.swift
//  
//
//  Created by Vitaly Chernysh on 07.07.2018.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var forecast: Forecast?

}
