//
//  Connectivity.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 03.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isInternetReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
