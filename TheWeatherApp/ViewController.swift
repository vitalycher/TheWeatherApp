//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 28.06.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import UIKit
import CoreLocation

var lon = 139
var lat = 35
var cnt = 2

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parameters = [String : Any]()
        
        parameters["lat"] = lat
        parameters["lon"] = lon
        parameters["cnt"] = cnt
        parameters["APPID"] = "02d119c82f4e09478c5d4583a67d25aa"
        
        APIClient.shared.perform(Requests.makeWeatherRequest(withParameters: parameters)) { (completion) in
            switch completion {
            case .failure(let error): print(error)
            case .singleObject(let forecast): print(forecast?.city?.name)
            default: break
            }
        }
    }

}
