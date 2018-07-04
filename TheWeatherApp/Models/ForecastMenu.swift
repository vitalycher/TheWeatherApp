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

    private(set) var forecast = BehaviorRelay(value: Forecast())
    private let disposeBag = DisposeBag()
    private var forecastDaysAmount = BehaviorRelay(value: ForecastProviderArrangements.minimumDaysForecast)
    private var userCoordinate: CLLocationCoordinate2D?

    func performInitialFetching(withCoordinate coordinate: CLLocationCoordinate2D) {
        userCoordinate = coordinate
        forecastDaysAmount.skip(1).subscribe(onNext: { _ in
            self.fetchForecast()
        }).disposed(by: disposeBag)
    }

    func setForecastDaysAmount(with daysAmount: Int) {
        forecastDaysAmount.accept(daysAmount)
    }

    func currentForecastDaysAmount() -> Int {
        return forecastDaysAmount.value
    }

    private func fetchForecast() {
        guard Connectivity.isInternetReachable else {
            //Fetch forecast from CoreData
            return
        }

        var parameters = [String : Any]()

        parameters["lat"] = userCoordinate?.latitude
        parameters["lon"] = userCoordinate?.longitude
        parameters["cnt"] = forecastDaysAmount.value
        parameters["APPID"] = ForecastProviderArrangements.accessKey

        APIClient.shared.perform(Requests.makeWeatherRequest(withParameters: parameters)) { (completion) in
            switch completion {
            case .failure(let error):
                print(error)
            case .singleObject(let forecast):
                if let forecast = forecast {
                    self.forecast.accept(forecast)
                }
            default: break
            }
        }
    }

}
