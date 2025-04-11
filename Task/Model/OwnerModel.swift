//
//  OwnerModel.swift
//  Task
//
//  Created by Maja Frąk on 11/04/2025.
//

import Foundation

struct OwnerModel: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
