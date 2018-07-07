////
////  ForecastOverviewViewModel.swift
////  TheWeatherApp
////
////  Created by Vitaly Chernysh on 05.07.2018.
////  Copyright © 2018 Vitaly Chernysh. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//struct ForecastOverviewViewModel: ForecastOverviewData {
//
//    var date: String
//    var verbalDescription: String
//    var minumumTemperature: String
//    var maximumTemperature: String
//    var humidity: String
//    var weatherIcon: UIImage
//
//    init(_ weatherDetails: WeatherDetails?) {
//        let undefinedValue = NSLocalizedString("Undefined", comment: "")
////        let weatherDescription = weatherDetails?.verbalDescription?.first?.headline ?? undefinedValue
//
////        date = DisplayDateService.convertedString(from: weatherDetails?.dateOfCalculation) ?? undefinedValue
////        verbalDescription = weatherDescription
////        minumumTemperature = String(Int(weatherDetails?.generalParameters?.minimumTemperature ?? 0.0))
////        maximumTemperature = String(Int(weatherDetails?.generalParameters?.maximumTemperature ?? 0.0))
////        humidity = String(Int(weatherDetails?.generalParameters?.humidity ?? 0.0))
//        
////        switch weatherDescription {
////        case "Clouds": weatherIcon = #imageLiteral(resourceName: "cloudy")
////        case "Clear": weatherIcon = #imageLiteral(resourceName: "sunny")
////        case "Rain": weatherIcon = #imageLiteral(resourceName: "rainy")
////        default: weatherIcon = UIImage()
////        }
//    }
//
//}
