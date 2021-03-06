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

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var barChartView: BarChartView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var currentDaysAmountLabel: UILabel!

    private let disposeBag = DisposeBag()
    private let locationService = LocationService()
    private let forecastMenu = ForecastMenu()

    override func viewDidLoad() {
        super.viewDidLoad()

        cityLabel.text = "Loading...".localized

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GeneralForecastCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "GeneralForecastCollectionViewCell")

        locationService.delegate = self
        locationService.authorizeAndFetchCoordinate()

        configureSliderParameters()

        slider.rx.value.subscribe(onNext: { sliderValue in
            let roundedValue = round(sliderValue)
            self.slider.value = roundedValue
            self.forecastMenu.setForecastDaysAmount(with: roundedValue.toInteger)
            self.currentDaysAmountLabel.text = "Showing forecast for \(roundedValue.toInteger) day(s)".localized
        }).disposed(by: disposeBag)

        barChartView.didSelectChartAtIndex.subscribe { chartIndex in
            if let indexValue = chartIndex.element {
                let indexPath = IndexPath(row: indexValue, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }

        }.disposed(by: disposeBag)
    }

    private func configureTemperatureCharts(for weatherDetails: [WeatherDetails]?)  {
        guard let weatherDetails = weatherDetails else { return }

        var charts = [ChartData]()

        let incomingDateFormatter = DateFormatter()
        incomingDateFormatter.dateFormat = ForecastProviderArrangements.incomingDateFormat

        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "d MMM, HH:mm"

        weatherDetails.forEach {
            if let maximumTemperature = $0.generalWeatherParameters?.maximumTemperature?.floatValue,
                let convertedDate = incomingDateFormatter.date(from: $0.dateOfCalculation ?? "") {
                    let displayDateString = displayDateFormatter.string(from: convertedDate)
                charts.append(ChartData(height: maximumTemperature, topTitle: String(maximumTemperature.toInteger), bottomTitle: displayDateString))
            }
        }

        barChartView.charts = charts
    }

    private func configureForecastMenu(withCoordinate coordinate: CLLocationCoordinate2D) {
        forecastMenu.fetchForecast(with: coordinate) {
            self.cityLabel.text = "Showing forecast for ".localized + (self.forecastMenu.forecast.city?.name ?? "you".localized)
        }
        createForecastMenuSubscriptions()
    }

    private func createForecastMenuSubscriptions() {
        forecastMenu.weatherDetailsForSelectedPeriod.subscribe { weatherDetails in
            if let wrappedWeatherDetails = weatherDetails.element {
                self.configureTemperatureCharts(for: wrappedWeatherDetails)
            }
            self.collectionView.reloadData()
            }.disposed(by: disposeBag)

        forecastMenu.didReceiveError.subscribe { errorEvent in
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
        return forecastMenu.weatherDetailsForSelectedPeriod.value?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralForecastCollectionViewCell",
                                                      for: indexPath) as! GeneralForecastCollectionViewCell
        let weatherDetails = forecastMenu.weatherDetailsForSelectedPeriod.value
        cell.configure(with: ForecastOverviewViewModel.init(weatherDetails?[indexPath.row]))
        return cell
    }

}

extension WeatherViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weatherDetails = forecastMenu.weatherDetailsForSelectedPeriod.value![indexPath.row]
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
