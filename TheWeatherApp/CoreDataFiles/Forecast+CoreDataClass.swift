//
//  Forecast+CoreDataClass.swift
//  
//
//  Created by Vitaly Chernysh on 07.07.2018.
//
//

import Foundation
import CoreData

@objc(Forecast)
public class Forecast: NSManagedObject, Decodable {

    required convenience init(from decoder: Decoder) throws {
        let context = decoder.userInfo[.context] as! NSManagedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Forecast", in: context)!
        
        self.init(entity: entity, in: context)
        
        let container = decoder.container(keyedBy: CodingKeys.self)
        self.property = container.decodeIfPresent(String.self, forKey: .property)
    }

}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
