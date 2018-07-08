//
//  APIClient.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 04.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

protocol ErrorExtracting {

    var extractor: Extractor { get }

}

class APIClient: ErrorExtracting {

    enum Completion<T> {
        case singleObject(T?)
        case collection([T])
        case failure(Error)
    }

    static var shared = APIClient()

    var extractor: Extractor = ResponseErrorExtractor()
    private var jsonEncoding: ParameterEncoding = URLEncoding.default

    convenience init(extractor: Extractor) {
        self.init()
        self.extractor = extractor
    }

    convenience init(jsonEncoding: ParameterEncoding) {
        self.init()
        self.jsonEncoding = jsonEncoding
    }

    convenience init(jsonEncoding: ParameterEncoding, extractor: Extractor) {
        self.init()
        self.jsonEncoding = jsonEncoding
        self.extractor = extractor
    }

    func perform<T: Decodable>(_ request: Request<T>, completion: @escaping (Completion<T>) -> Void) {
        Alamofire.request(request.jsonUrlString, method: request.method, parameters: request.parameters, encoding: jsonEncoding, headers: request.header).responseJSON { response in

            if let error = self.extractor.error(from: response) {
                completion(.failure(error))
                return
            }

            guard let data = response.data else {
                completion(.failure(ApplicationError(code: InternalErrors.nilData)))
                return
            }

            guard data.count > 0 else {
                completion(.singleObject(nil))
                return
            }

            PersistentStorage.shared.reset()

            let decoder = JSONDecoder()
            decoder.userInfo[.context] = PersistentStorage.shared.objectContext

            do {
                if response.result.value is NSArray {
                    let decodedCollection = try decoder.decode([T].self, from: data)
                    PersistentStorage.shared.saveContext()
                    completion(.collection(decodedCollection))
                } else {
                    let decodedSingleObject = try decoder.decode(T.self, from: data)
                    PersistentStorage.shared.saveContext()
                    completion(.singleObject(decodedSingleObject))
                }
            } catch {
                completion(.failure(ApplicationError(code: InternalErrors.mappingError)))
            }
        }
    }

}
