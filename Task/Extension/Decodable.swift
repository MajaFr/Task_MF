//
//  Decodable.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation

extension Decodable {
    static func fromJson<T: Decodable>(_ jsonString: String, _ decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try fromJsonData(Data(jsonString.utf8), decoder)
    }
    
    static func fromJsonData<T: Decodable>(_ jsonData: Data, _ decoder: JSONDecoder = JSONDecoder()) throws -> T {
        let data = try decoder.decode(T.self, from: jsonData)
        return data
    }
}
