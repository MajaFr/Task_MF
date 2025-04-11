//
//  TrendingProjectsModel.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import Foundation

struct TrendingProjectsModel: Codable {
    let totalCount: Int
    let items: [ProjectModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
