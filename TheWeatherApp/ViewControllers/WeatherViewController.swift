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

    @IBOutlet private weak var barChartView: BarChartView!
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
        
        barChartView.didSelectChartIndex.subscribe { chartIndex in
            if let indexValue = chartIndex.element {
                let indexPath = IndexPath(row: indexValue, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        barChartView.charts = generateDataEntries()
    }
    
    func generateDataEntries() -> [ChartData] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [ChartData] = []
        for i in 0..<20 {
            let value = (arc4random() % 90) + 10
            let height: Float = Float(value) / 100.0
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            result.append(ChartData(color: colors[i % colors.count], height: height, topTitle: "\(value)", bottomTitle: formatter.string(from: date)))
        }
        return result
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
        cell.configure(with: ForecastOverviewViewModel.init(weatherDetails[indexPath.row]))
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
