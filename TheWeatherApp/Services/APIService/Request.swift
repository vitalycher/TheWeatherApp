//
//  Request.swift
//  111Secuirty
//
//  Created by Vitaly Chernysh on 1/26/18.
//  Copyright © 2018 Egor Bozko. All rights reserved.
//

import Foundation
import Alamofire

class Request<T> {
    
    let jsonUrlString: String
    let method: HTTPMethod
    let parameters: [String : Any]?
    let header: [String : String]?
    
    init(jsonUrlString: String,
         method: HTTPMethod,
         parameters: [String : Any]? = nil,
         header: [String : String]? = nil)
    {
        self.jsonUrlString = jsonUrlString
        self.method = method
        self.parameters = parameters
        self.header = header
    }
    
}
