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
    @IBOutlet private weak var currentDaysAmountLabel: UILabel!

    private let disposeBag = DisposeBag()
    private let locationService = LocationService()
    private let forecastMenu = ForecastMenu()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GeneralForecastCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "GeneralForecastCollectionViewCell")

        locationService.delegate = self
        locationService.authorizeAndFetchCoordinates()

        configureSliderParameters()

        slider.rx.value.subscribe(onNext: { sliderValue in
            let roundedValue = round(sliderValue)
            self.slider.value = roundedValue
            self.forecastMenu.setForecastDaysAmount(with: roundedValue.toInteger)
            self.currentDaysAmountLabel.text = "Showing forecast for \(roundedValue.toInteger) day(s)".localized
        }).disposed(by: disposeBag)
    }

    private func configureForecastMenu(withCoordinate coordinate: CLLocationCoordinate2D) {
        forecastMenu.fetchForecast(with: coordinate)
        createForecastMenuSubscriptions()
    }

    private func createForecastMenuSubscriptions() {
        forecastMenu.weatherDetailsForSelectedPeriod.subscribe { forecast in
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
        slider.value = Float(forecastMenu.forecastDaysAmount)
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
        return forecastMenu.weatherDetailsForSelectedPeriod.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralForecastCollectionViewCell",
                                                      for: indexPath) as! GeneralForecastCollectionViewCell
        let weatherDetails = forecastMenu.weatherDetailsForSelectedPeriod.value
//        cell.configure(with: ForecastOverviewViewModel.init(weatherDetails[indexPath.row]))
        return cell
    }

}

extension WeatherViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weatherDetails = forecastMenu.weatherDetailsForSelectedPeriod.value[indexPath.row]
        let detailedForecastViewController = DetailedForecastViewController(weatherDetails: weatherDetails)
        navigationController?.pushViewController(detailedForecastViewController, animated: true)
    }

}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.4, height: collectionView.frame.height)
    }

}
