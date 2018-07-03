//
//  ResponseValidator.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 02.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import Alamofire

protocol Extractor {
    func error(from response: DataResponse<Any>) -> Error?
}

class ResponseErrorExtractor: Extractor {
    
    func error(from response: DataResponse<Any>) -> Error? {
        guard let error = response.error else {
            if let responseDictionary = response.result.value as? [String : AnyObject],
                let errorDescription = responseDictionary["errors"] as? String {
                return APIError(description: errorDescription)
            } else {
                return nil
            }
        }
        
        if let alamofireError = error as? AFError {
            var assortedError: ApplicationError?
            
            switch alamofireError {
            case .responseSerializationFailed(reason: let reason):
                switch reason {
                //Error ignoring
                case .inputDataNilOrZeroLength: return nil
                default: break
                }
            case .responseValidationFailed(reason: let reason):
                switch reason {
                case .unacceptableStatusCode(code: let statusCode):
                    switch statusCode {
                    case 404:
                        assortedError = ApplicationError(code: NetworkErrors.notFound)
                    case 401:
                        assortedError = ApplicationError(code: NetworkErrors.badToken)
                    default: break
                    }
                default: break
                }
            default: break
            }
            return assortedError ?? alamofireError
        } else {
            return error
        }
    }
    
}
