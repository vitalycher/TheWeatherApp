//
//  WeatherDetailsDecodable.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

class WeatherDetailsDecodable: WeatherDetails, Decodable {

    enum CodingKeys: String, CodingKey {
        case generalParameters = "main"
        case verbalDescription = "weather"
        case cloudPercentage = "clouds"
        case windDetails = "wind"
        case dateOfCalculation = "dt_txt"
    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherDetails", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateOfCalculation = try container.decodeIfPresent(String.self, forKey: .dateOfCalculation)
        generalWeatherParameters = try container.decodeIfPresent(GeneralWeatherParametersDecodable.self, forKey: .generalParameters)
        cloudPercentage = try container.decodeIfPresent(CloudPercentageDecodable.self, forKey: .cloudPercentage)
        windDetails = try container.decodeIfPresent(WindDetailsDecodable.self, forKey: .windDetails)
        
        let verbalWeatherDescriptionArray: [VerbalWeatherDescriptionDecodable] = (try container.decodeIfPresent([VerbalWeatherDescriptionDecodable].self, forKey: .verbalDescription))!
        
        verbalWeatherDescription = NSSet(array: verbalWeatherDescriptionArray)
    }

}
