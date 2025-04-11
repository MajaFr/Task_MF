//
//  Endpoint.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}
