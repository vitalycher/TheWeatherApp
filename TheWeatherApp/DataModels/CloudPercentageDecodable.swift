//
//  CloudPercentageDecodable.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

class CloudPercentageDecodable: CloudPercentage, Decodable {

    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "CloudPercentage", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cloudiness = try container.decodeIfPresent(Double.self, forKey: .cloudiness)?.toNSNumber()
    }

}
