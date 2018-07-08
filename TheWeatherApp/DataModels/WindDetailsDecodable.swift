//
//  WindDetailsDecodable.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

class WindDetailsDecodable: WindDetails, Decodable {

    enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "WindDetails", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try container.decodeIfPresent(Double.self, forKey: .speed)?.toNSNumber()
        degrees = try container.decodeIfPresent(Double.self, forKey: .degrees)?.toNSNumber()
    }

}
