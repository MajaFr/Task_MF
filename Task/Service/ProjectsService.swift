//
//  ProjectsService.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation
import OSLog

protocol ProjectsServiceProtocol {
    func getTrendingProjects() async -> Result<TrendingProjectsModel, Error>
}

class ProjectsService: ProjectsServiceProtocol {
    private let logger = Logger()
    private let httpsConnection: HttpsConnection = HttpsConnection()
    
    func getTrendingProjects() async -> Result<TrendingProjectsModel, Error> {
        logger.debug(#function)
        
        do {
            let result = try await performGetTrendingProjects()
            logger.info("Get trending projects successful")
            return .success(result)
        } catch {
            logger.debug("Get trending projects failed: \(error)")
            return .failure(error)
        }
    }
    
    func performGetTrendingProjects() async throws -> TrendingProjectsModel {
        logger.debug(#function)
        do {
            let data = try await httpsConnection.data(ProjectsEndpoint.getProjectsGitHub)
            logger.info("Get trending projects successful")
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let projects: TrendingProjectsModel = try TrendingProjectsModel.fromJsonData(data, decoder)
            return projects
        } catch {
            logger.debug("Get trending projects failed: \(error)")
            throw error
        }
    }
}
