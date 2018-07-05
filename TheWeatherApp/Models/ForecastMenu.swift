//
//  ForecastMenu.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 03.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation
import Alamofire

class ForecastMenu {

    var didRecieveError: Observable<Error> {
        return errorPublishSubject.asObservable()
    }

    private(set) var forecast = BehaviorRelay(value: Forecast())
    private(set) var weatherDetailsForSelectedPeriod = BehaviorRelay(value: [WeatherDetails()])
    private(set) var forecastDaysAmount = ForecastProviderArrangements.minimumDaysForecast

    private let disposeBag = DisposeBag()
    private var errorPublishSubject = PublishSubject<Error>()

    private func setWeatherDetails(withDaysAmount daysAmount: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = Date()
        let daysOffset = daysAmount - 1

        
        if let weatherDetails = forecast.value.weatherDetails {
            let filteredWeatherDetailes = Array(weatherDetails).filter { weatherDetail in
                if let dateOfForecastString = weatherDetail.dateOfCalculation,
                    let forecastDate = dateFormatter.date(from: dateOfForecastString),
                    let maximumDate = Calendar.current.date(byAdding: .day, value: daysOffset, to: currentDate)?.endOfDay {
                    return forecastDate.isBetween(currentDate, and: maximumDate)
                } else {
                    return false
                }
            }
            weatherDetailsForSelectedPeriod.accept(Array(filteredWeatherDetailes))
        }
    }

    func setForecastDaysAmount(with daysAmount: Int) {
        forecastDaysAmount = daysAmount
        setWeatherDetails(withDaysAmount: daysAmount)
    }

    func fetchForecast(with coordinate: CLLocationCoordinate2D) {
        guard Connectivity.isInternetReachable else {
            //Fetch forecast from CoreData
            return
        }

        var parameters = [String : Any]()

        parameters["lat"] = coordinate.latitude
        parameters["lon"] = coordinate.longitude
        parameters["APPID"] = ForecastProviderArrangements.accessKey
        parameters["units"] = ForecastProviderArrangements.celsiusFormat

        APIClient.shared.perform(Requests.makeWeatherRequest(withParameters: parameters)) { (completion) in
            switch completion {
            case .failure(let error):
                self.errorPublishSubject.onNext(error)
            case .singleObject(let forecast):
                if let forecast = forecast {
                    self.forecast.accept(forecast)
                    self.setWeatherDetails(withDaysAmount: self.forecastDaysAmount)
                }
            default: break
            }
        }
    }

}
