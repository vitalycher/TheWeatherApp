//
//  CLLocationCoordinate2D + DefaultCoordinate.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 04.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    static let defaultCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 37.3)!, longitude: CLLocationDegrees(exactly: -122.0)!)
}
