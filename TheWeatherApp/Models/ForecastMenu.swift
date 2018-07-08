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

    var didReceiveError: Observable<Error> {
        return errorPublishSubject.asObservable()
    }

    private(set) var forecast: Forecast! {
        didSet {
            setWeatherDetails(withDaysAmount: forecastDaysAmount)
        }
    }

    private(set) var weatherDetailsForSelectedPeriod: BehaviorRelay<[WeatherDetails]?> = BehaviorRelay(value: nil)
    private(set) var forecastDaysAmount = ForecastProviderArrangements.minimumDaysForecast

    private let disposeBag = DisposeBag()
    private var errorPublishSubject = PublishSubject<Error>()

    private func setWeatherDetails(withDaysAmount daysAmount: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ForecastProviderArrangements.incomingDateFormat
        let currentDate = Date()
        let daysOffset = daysAmount - 1

        guard let forecast = forecast else { return }
        
        let weatherDetails = forecast.sortedWeatherDetails
        let filteredWeatherDetailes = weatherDetails.filter { weatherDetail in
            if let dateOfForecastString = weatherDetail.dateOfCalculation,
                let forecastDate = dateFormatter.date(from: dateOfForecastString),
                let maximumDate = Calendar.current.date(byAdding: .day, value: daysOffset, to: currentDate)?.endOfDay {
                return forecastDate.isBetween(currentDate, and: maximumDate)
            } else {
                return false
            }
        }
        weatherDetailsForSelectedPeriod.accept(filteredWeatherDetailes)
    }

    func setForecastDaysAmount(with daysAmount: Int) {
        forecastDaysAmount = daysAmount
        setWeatherDetails(withDaysAmount: daysAmount)
    }

    func fetchForecast(with coordinate: CLLocationCoordinate2D, completed: @escaping () -> Void) {
        guard Connectivity.isInternetReachable else {
            self.forecast = PersistentStorage.shared.forecast()
            completed()
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
                    self.forecast = forecast
                    completed()
                }
            default: break
            }
        }
    }

}
