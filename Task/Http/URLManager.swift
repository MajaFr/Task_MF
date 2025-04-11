//
//  URLManager.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import Foundation
import OSLog

enum ConnectionError: Error {
    case invalidBaseURL
}

final class URLManager {
    
    private let baseURL: URL
    private let logger = Logger(subsystem: "URLManager", category: "Connection")
    
    init(baseURLString: String = "https://api.github.com") {
        if let url = URL(string: baseURLString) {
            self.baseURL = url
        } else {
            logger.warning("Invalid base URL.")
            self.baseURL = URL(string: "https://api.github.com")!
        }
    }
    
    func makeURL(for path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        var formattedPath = path
        if !path.hasPrefix("/") {
            formattedPath = "/" + path
        }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path = formattedPath
        components?.queryItems = queryItems
        return components?.url
    }
}
