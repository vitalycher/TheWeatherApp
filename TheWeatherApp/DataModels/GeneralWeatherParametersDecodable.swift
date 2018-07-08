//
//  GeneralWeatherParametersDecodable.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

class GeneralWeatherParametersDecodable: GeneralWeatherParameters, Decodable {

    enum CodingKeys: String, CodingKey {
        case averageTemperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case defaultPressure = "pressure"
        case seaLevelAtmoPressure = "sea_level"
        case groundLevelAtmoPressure = "grnd_level"
        case humidity
    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "GeneralWeatherParameters", in: context) else { fatalError() }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        averageTemperature = try container.decodeIfPresent(Double.self, forKey: .averageTemperature)?.toNSNumber()
        minimumTemperature = try container.decodeIfPresent(Double.self, forKey: .minimumTemperature)?.toNSNumber()
        maximumTemperature = try container.decodeIfPresent(Double.self, forKey: .maximumTemperature)?.toNSNumber()
        defaultPressure = try container.decodeIfPresent(Double.self, forKey: .defaultPressure)?.toNSNumber()
        seaLevelAtmoPressure = try container.decodeIfPresent(Double.self, forKey: .seaLevelAtmoPressure)?.toNSNumber()
        groundLevelAtmoPressure = try container.decodeIfPresent(Double.self, forKey: .groundLevelAtmoPressure)?.toNSNumber()
        humidity = try container.decodeIfPresent(Double.self, forKey: .humidity)?.toNSNumber()
    }

}
