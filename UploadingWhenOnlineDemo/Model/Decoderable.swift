//
//  Decoder.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/3/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation


protocol Decoderable {
    static func decodeJSON<T:Codable>(_ res: Any, To model: T.Type, format: JSONDecoder.KeyDecodingStrategy) -> Any?
}

extension Decoderable {
    
    static func decodeJSON<T:Codable>(_ res: Any, To model: T.Type, format: JSONDecoder.KeyDecodingStrategy) -> Any?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = format
        do {
            guard let jsonData = Data.convertToData(res) else{
                debugPrint("[Decoderable] decodeJSON func fails to convert json to data.")
                return nil
            }
            var result: Any?
            
            if let _ = res as? [String: Any] {
                let object = try decoder.decode(T.self, from: jsonData)
                result = object
            } else {
                let list = try decoder.decode([T].self, from: jsonData)
                result = list
            }
            return result
        } catch let _error {
            debugPrint(_error)
            return nil
        }
    }
}
