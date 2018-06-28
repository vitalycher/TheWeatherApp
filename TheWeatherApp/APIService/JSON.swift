//
//  JSON.swift
//  111Secuirty
//
//  Created by Vitaly Chernysh on 2/6/18.
//  Copyright © 2018 Egor Bozko. All rights reserved.
//

import Foundation

struct JSON: Decodable {
    
    private var value: Any
    
    public var dictionary: [String : Any]? {
        return value as? [String : Any]
    }
    
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            var result = [String: Any]()
            try container.allKeys.forEach { (key) throws in
                result[key.stringValue] = try container.decode(JSON.self, forKey: key).value
            }
            value = result
        } else if var container = try? decoder.unkeyedContainer() {
            var result = [Any]()
            while !container.isAtEnd {
                result.append(try container.decode(JSON.self).value)
            }
            value = result
        } else if let container = try? decoder.singleValueContainer() {
            if let intValue = try? container.decode(Int.self) {
                value = intValue
            } else if let doubleValue = try? container.decode(Double.self) {
                value = doubleValue
            } else if let boolValue = try? container.decode(Bool.self) {
                value = boolValue
            } else if let stringValue = try? container.decode(String.self) {
                value = stringValue
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "The container contains nothing serializable")
            }
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not serialize"))
        }
    }
    
}
