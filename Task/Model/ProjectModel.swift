//
//  ProjectModel.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import Foundation

struct ProjectModel: Codable, Identifiable {
    let id: Int
    let fullName: String
    let name: String
    let owner: OwnerModel
    let description: String?
    let language: String?
    let forksCount: Int
    let createdAt: Date?
    let pushedAt: Date?
    let updatedAt: Date?
    let archived: Bool
    let watchers: Int
    let stargazersCount: Int?
    let size: Int
    let license: LicenseModel?
    let topics: [String]
    let openIssues: Int
    let url: String
    let isPrivate : Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, owner, language, archived, watchers, size, topics, license, description
        case fullName = "full_name"
        case forksCount = "forks_count"
        case pushedAt = "pushed_at"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case stargazersCount = "stargazers_count"
        case openIssues = "open_issues"
        case url = "html_url"
        case isPrivate = "private"
    }
}

struct LicenseModel: Codable {
    let key: String
    let name: String
    let spdxID: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case key, name, url
        case spdxID = "spdx_id"
    }
}
