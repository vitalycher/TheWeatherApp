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

    @IBOutlet weak private var slider: UISlider!
    
    private var disposeBag = DisposeBag()
    private var locationManager = CLLocationManager()
    private var forecastMenu: ForecastMenu?

    @IBAction private func sliderDidChangeValue(_ sender: UISlider) {
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.requestAlwaysAuthorization()

        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.value = 1
        
        slider.rx.value.subscribe(onNext: { sliderValue in
            self.forecastMenu?.forecastDaysAmount.accept(Int(sliderValue))
        }).disposed(by: disposeBag)
    
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    private func configureForecastMenu(withCoordinate coordinate: CLLocationCoordinate2D) {
        forecastMenu = ForecastMenu(coordinate: coordinate, forecastDaysAmount: Int(slider.value))
        forecastMenu?.forecast.skip(1).subscribe(onNext: { forecast in
            print(forecast.city?.name)
        }).disposed(by: disposeBag)
    }

}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationManager.stopUpdatingLocation()
        configureForecastMenu(withCoordinate: coordinate)
    }
}
