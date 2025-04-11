//
//  TrendingProjectsViewModelTests.swift
//  TaskTests
//
//  Created by Maja Frąk on 11/04/2025.
//

import XCTest
@testable import Task

@MainActor
final class TrendingProjectsViewModelTests: XCTestCase {
    
    class MockHttpsConnection: HttpsConnection {
        var dataToReturn: Data?
        var errorToThrow: Error?

        override func data(_ endpoint: Endpoint, body: Encodable? = nil) async throws -> Data {
            if let error = errorToThrow {
                throw error
            }
            return dataToReturn ?? Data()
        }
    }

    class MockProjectsService: ProjectsServiceProtocol {
        var result: Result<TrendingProjectsModel, Error> = .success(TrendingProjectsModel(totalCount: 100, items: []))

        func getTrendingProjects() async -> Result<TrendingProjectsModel, Error> {
            result
        }
    }

    func testGetListProjectsSetsItems() async {
        let mockService = MockProjectsService()
        mockService.result = .success(TrendingProjectsModel(totalCount: 100, items: [.mock(id: 1, language: "Swift")]))
        let viewModel = TrendingProjectsViewModel(projectsService: mockService)
        await viewModel.getListProjects()
        XCTAssertEqual(viewModel.items.count, 1)
    }

    func testGetListProjectsFailure() async {
        let mockService = MockProjectsService()
        mockService.result = .failure(URLError(.notConnectedToInternet))
        let viewModel = TrendingProjectsViewModel(projectsService: mockService)
        viewModel.items = [.mock(id: 1, language: "Swift")]
        await viewModel.getListProjects()
        XCTAssertEqual(viewModel.items.count, 1)
    }
}

extension ProjectModel {
    static func mock(id: Int, language: String? = nil) -> ProjectModel {
        ProjectModel(
            id: id,
            fullName: "test",
            name: "test",
            owner: OwnerModel(login: "user", id: 1, avatarURL: ""),
            description: "desc",
            language: language,
            forksCount: 10,
            createdAt: nil,
            pushedAt: nil,
            updatedAt: nil,
            archived: false,
            watchers: 100,
            stargazersCount: 200,
            size: 1234,
            license: nil,
            topics: [],
            openIssues: 1,
            url: "https://github.com",
            isPrivate: false
        )
    }
}

