//
//  ProjectsEndpoint.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation

enum ProjectsEndpoint {
    case getProjectsGitHub
}

extension ProjectsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getProjectsGitHub:
            return "search/repositories"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProjectsGitHub:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getProjectsGitHub:
            return [
                URLQueryItem(name: "q", value: "stars:>1000"),
                URLQueryItem(name: "sort", value: "stars"),
                URLQueryItem(name: "order", value: "desc"),
                URLQueryItem(name: "per_page", value: "1000")
            ]
        }
    }
}
