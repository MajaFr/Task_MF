//
//  ErrorModel.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation

struct ErrorModel: Error, Codable {
    let errorCode: String
    let reasonCode: String
    let description: String
    
    init(errorCode: String, reasonCode: String, description: String) {
        self.errorCode = errorCode
        self.reasonCode = reasonCode
        self.description = description
    }
    
    func toString() -> String {
        return "{ errorCode=\(errorCode), reasonCode=\(reasonCode), description=\(description) }"
    }
}
