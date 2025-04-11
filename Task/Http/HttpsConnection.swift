//
//  HttpsConnection.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation
import OSLog

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class HttpsConnection: NSObject {
    
    private let logger = Logger(subsystem: "HttpsConnection", category: "Connection")
    private let session: URLSession
    private let urlManager: URLManager
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared) {
        self.session = session
        self.urlManager = URLManager()
        self.decoder = JSONDecoder()
    }
    
    func httpData(for request: URLRequest) async throws -> Data {
        logRequest(request)
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ErrorModel(
                errorCode: ErrorCodes.responseError.rawValue,
                reasonCode: "Invalid Response",
                description: "Server response could not be parsed"
            )
        }
        
        logResponse(data: data, response: httpResponse)
        
        switch httpResponse.statusCode {
        case 200..<300:
            return data
        case 401:
            throw ErrorModel(
                errorCode: ErrorCodes.unauthorized.rawValue,
                reasonCode: "Unauthorized",
                description: "Access denied. Invalid token."
            )
        default:
            throw ErrorModel(
                errorCode: ErrorCodes.responseError.rawValue,
                reasonCode: "StatusCode_\(httpResponse.statusCode)",
                description: "Server responded with code \(httpResponse.statusCode)"
            )
        }
    }
    
    func data<T: Decodable>(_ endpoint: Endpoint, body: Encodable? = nil) async throws -> T {
        let request = try await makeRequest(from: endpoint, body: body)
        let data = try await httpData(for: request)
        return try decoder.decode(T.self, from: data)
    }
    
    func data(_ endpoint: Endpoint, body: Encodable? = nil) async throws -> Data {
        let request = try await makeRequest(from: endpoint, body: body)
        return try await httpData(for: request)
    }
    
    private func makeRequest(from endpoint: Endpoint, body: Encodable?) async throws -> URLRequest {
        let url = try makeUrl(from: endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        return request
    }
    
    private func makeUrl(from endpoint: Endpoint) throws -> URL {
        guard let url = urlManager.makeURL(for: endpoint.path, queryItems: endpoint.queryItems) else {
            throw ErrorModel(
                errorCode: ErrorCodes.buildRequest.rawValue,
                reasonCode: "URLConstruction",
                description: "Failed to build the request URL"
            )
        }
#if DEBUG
        logger.info("Constructed URL: \(url)")
#endif
        return url
    }
    
    private func makeBody(from params: [String: Any]?) -> Data? {
        guard let params, !params.isEmpty else { return nil }
        return try? JSONSerialization.data(withJSONObject: params)
    }
    
    private func logRequest(_ request: URLRequest) {
#if DEBUG
        logger.debug("===REQUEST===")
        logger.debug("Request to: \(request.url?.absoluteString ?? "")")
        logger.debug("Method: \(request.httpMethod ?? "")")
        logger.debug("Headers: \(request.allHTTPHeaderFields ?? [:])")
        logger.debug("==================")
#endif
    }
    
    private func logResponse(data: Data, response: HTTPURLResponse) {
#if DEBUG
        logger.debug("===RESPONSE===")
        logger.debug("Response Status Code: \(response.statusCode)")
        logger.debug("URL: \(response.url?.absoluteString ?? "N/A")")
        logger.debug("==================")
#endif
    }
}
