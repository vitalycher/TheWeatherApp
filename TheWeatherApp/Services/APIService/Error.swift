//
//  Error.swift
//  111Secuirty
//
//  Created by Vitaly Chernysh on 3/12/18.
//  Copyright © 2018 Egor Bozko. All rights reserved.
//

import Foundation

extension Error {

    var filteredDescription: String {
        if let applicationError = self as? ApplicationError {
            return "error.\(type(of: applicationError.code).domain).\(applicationError.code)".localized
        } else if let apiError = self as? APIError {
            return apiError.description
        } else {
            return localizedDescription
        }
    }

}

protocol ErrorCode {

    static var domain: String { get }
    
    var rawValue: String { get }

}

enum NetworkErrors: String, ErrorCode {

    static let domain = "network"
    
    case badToken = "401"
    case notFound = "404"

}

enum InternalErrors: String, ErrorCode {

    static let domain = "internal"
    
    case nilData = "nilData"
    case mappingError = "mappingError"

}

class ApplicationError: Error {

    let code: ErrorCode
    
    init(code: ErrorCode) {
        self.code = code
    }

}

class APIError: Error {

    let description: String
    
    init(description: String) {
        self.description = description
    }

}
