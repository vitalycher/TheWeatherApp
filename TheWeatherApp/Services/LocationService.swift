//
//  LocationService.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 04.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {

    func locationService(_ service: LocationService, didFetchCoordinate coordinate: CLLocationCoordinate2D)
    func locationServiceDidRejectUpdatingCoordinate(service: LocationService)

}

final class LocationService: NSObject {

    weak var delegate: LocationServiceDelegate?
    private let locationManager = CLLocationManager()

    func authorizeAndFetchCoordinate() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    private func fetchCoordinate() {
        if CLLocationManager.locationServicesEnabled() {
            if let coordinate = locationManager.location?.coordinate {
                delegate?.locationService(self, didFetchCoordinate: coordinate)
            }
        } else {
            delegate?.locationServiceDidRejectUpdatingCoordinate(service: self)
        }
    }

}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            fetchCoordinate()
        }
    }

}
