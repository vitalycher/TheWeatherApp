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

class LocationService {
    
    weak var delegate: LocationServiceDelegate?
    private let locationManager = CLLocationManager()

    func authorizeAndFetchCoordinates() {
        locationManager.requestWhenInUseAuthorization()
        updateCoordinateIfAuthorized()
    }

    private func updateCoordinateIfAuthorized() {
        if CLLocationManager.locationServicesEnabled() {
            if let coordinate = locationManager.location?.coordinate {
                delegate?.locationService(self, didFetchCoordinate: coordinate)
            }
        } else {
            delegate?.locationServiceDidRejectUpdatingCoordinate(service: self)
        }
    }
    
}
