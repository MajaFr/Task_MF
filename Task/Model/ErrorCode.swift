//
//  ErrorCode.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation

public enum ErrorCodes: String {
    case unauthorized = "401"
    case buildRequest = "402"
    case responseError = "403"

    
    public var reasonCode: String {
        switch self {
        case .unauthorized:
            return "UNAUTHORIZED"
        case .buildRequest:
            return "BUILD_REQUEST_FAILED"
        case .responseError:
            return "RESPONSE_ERROR"
        }
    }
}
