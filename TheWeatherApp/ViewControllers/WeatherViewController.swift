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
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    private let locationService = LocationService()
    private var forecastMenu = ForecastMenu()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GeneralForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GeneralForecastCollectionViewCell")

        locationService.delegate = self
        locationService.authorizeAndFetchCoordinates()

        configureSliderParameters()

        slider.rx.value.subscribe(onNext: { sliderValue in
            self.slider.value = round(sliderValue)
//            print(round(sliderValue))
//            print(sliderValue)
            self.forecastMenu.setForecastDaysAmount(with: Int(round(sliderValue)))
        }).disposed(by: disposeBag)
    }

    private func configureForecastMenu(withCoordinate coordinate: CLLocationCoordinate2D) {
        forecastMenu.performInitialFetching(withCoordinate: coordinate)
        
        forecastMenu.forecast.skip(1).subscribe { forecast in
            self.collectionView.reloadData()
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

extension WeatherViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastMenu.currentForecastDaysAmount()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralForecastCollectionViewCell", for: indexPath) as? GeneralForecastCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}

extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.4, height: collectionView.frame.height)
    }
}
