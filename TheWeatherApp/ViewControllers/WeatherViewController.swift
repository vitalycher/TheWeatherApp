//
//  WeatherViewController.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import UIKit
import CoreLocation
import RxCocoa
import RxSwift

class WeatherViewController: UIViewController {

    @IBOutlet private weak var slider: UISlider!

    private let disposeBag = DisposeBag()
    private let locationService = LocationService()
    private var forecastMenu = ForecastMenu()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationService.delegate = self
        locationService.authorizeAndFetchCoordinates()

        configureSliderParameters()

        slider.rx.value.subscribe(onNext: { sliderValue in
            self.slider.value = round(sliderValue)
            self.forecastMenu.setForecastDaysAmount(with: Int(sliderValue))
        }).disposed(by: disposeBag)
    }

    private func configureForecastMenu(withCoordinate coordinate: CLLocationCoordinate2D) {
        forecastMenu.performInitialFetching(withCoordinate: coordinate)
        
        forecastMenu.forecast.skip(1).subscribe { forecast in
            print(forecast.element?.city)
        }.disposed(by: disposeBag)
        
        forecastMenu.didRecieveError.subscribe { errorEvent in
            if let error = errorEvent.element {
                print(error.filteredDescription)
            }
        }.disposed(by: disposeBag)
    }

    private func configureSliderParameters() {
        slider.minimumValue = Float(ForecastProviderArrangements.minimumDaysForecast)
        slider.maximumValue = Float(ForecastProviderArrangements.maximumDaysForecast)
        slider.isContinuous = false
        slider.value = Float(forecastMenu.currentForecastDaysAmount())
    }

}

extension WeatherViewController: LocationServiceDelegate {
    func locationService(_ service: LocationService, didFetchCoordinate coordinate: CLLocationCoordinate2D) {
        configureForecastMenu(withCoordinate: coordinate)
    }
    func locationServiceDidRejectUpdatingCoordinate(service: LocationService) {
        configureForecastMenu(withCoordinate: CLLocationCoordinate2D.defaultCoordinate)
    }
}
