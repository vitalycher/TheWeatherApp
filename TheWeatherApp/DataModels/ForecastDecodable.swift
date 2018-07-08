//
//  ForecastDecodable.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

class ForecastDecodable: Forecast, Decodable {

    enum CodingKeys: String, CodingKey {
        case city
        case weatherDetails = "list"
        case title = "title"
    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Forecast", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decodeIfPresent(CityDecodable.self, forKey: .city)
        
        let weatherDetailsArray: [WeatherDetails] = (try container.decodeIfPresent([WeatherDetailsDecodable].self, forKey: .weatherDetails))!
        weatherDetails = NSSet(array: weatherDetailsArray)
    }

}
