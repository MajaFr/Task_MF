//
//  TrendingProjectsViewModel.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import Foundation
import OSLog

@MainActor
class TrendingProjectsViewModel: ObservableObject {
    private let logger = Logger()
    private let projectsService: ProjectsServiceProtocol
    @Published var trendingProjectsModel: [TrendingProjectsModel] = []
    @Published var isNetworkAvailable: Bool = true
    @Published var items: [ProjectModel] = []
    @Published var selectedLanguage: String? = nil
    
    init(projectsService: ProjectsServiceProtocol = ProjectsService()) {
        self.projectsService = projectsService
    }
    
    var availableLanguages: [String] {
        let language  = items.compactMap { $0.language?.capitalized }
        return Array(Set(language)).sorted()
    }

    var filteredItems: [ProjectModel] {
        guard let language = selectedLanguage else { return items }
        return items.filter { $0.language?.lowercased() == language.lowercased() }
    }
    
    func getListProjects() async {
        switch await projectsService.getTrendingProjects() {
        case let .success(model):
            self.items = model.items
        case let .failure(error):
            logger.log("Failed to fetch trending projects: \(error)")
        }
    }
}
