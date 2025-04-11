//
//  TaskApp.swift
//  Task
//
//  Created by Maja Frąk on 10/04/2025.
//

import SwiftUI

@main
struct TaskApp: App {
    @StateObject private var appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appRouter.router {
                case .trendingProjectsView:
                    TrendingProjectsView(viewModel: TrendingProjectsViewModel())
                case .detailView(let project):
                    DetailProjectView(project: project, appRouter: appRouter)
                }
            }
            .environmentObject(appRouter)
        }
    }
}

enum AppRouterCase {
    case trendingProjectsView
    case detailView(project: ProjectModel)
}

class AppRouter: ObservableObject {
    @Published private(set) var router: AppRouterCase = .trendingProjectsView
    
    func route(_ to: AppRouterCase) {
        withAnimation { router = to }
    }
}
