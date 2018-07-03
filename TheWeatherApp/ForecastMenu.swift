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

    private let disposeBag = DisposeBag()

    var forecast = BehaviorRelay(value: Forecast())
    var forecastDaysAmount = BehaviorRelay(value: 0)
    var userCoordinate: CLLocationCoordinate2D

    private let forecastProviderKey = "02d119c82f4e09478c5d4583a67d25aa"
    
    init(coordinate: CLLocationCoordinate2D, forecastDaysAmount: Int) {
        self.userCoordinate = coordinate
        self.forecastDaysAmount.accept(forecastDaysAmount)
        
        self.forecastDaysAmount.asObservable().subscribe(onNext: { _ in
            self.fetchForecast()
        }).disposed(by: disposeBag)
    }
    
    private func fetchForecast() {
        guard Connectivity.isInternetReachable else {
            //Fetch forecast from CoreData
            return
        }
        
        var parameters = [String : Any]()

        parameters["lat"] = userCoordinate.latitude
        parameters["lon"] = userCoordinate.longitude
        parameters["cnt"] = forecastDaysAmount.value
        parameters["APPID"] = forecastProviderKey
        
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
