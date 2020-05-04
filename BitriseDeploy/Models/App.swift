//
//  App.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 03/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import Foundation

struct App: Codable {
    let avatarURL: String
    let isDisabled, isPublic: Bool
    let projectType, provider, repoOwner, repoSlug: String
    let repoURL, slug: String
    let status: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case isDisabled = "is_disabled"
        case isPublic = "is_public"
        case projectType = "project_type"
        case provider
        case repoOwner = "repo_owner"
        case repoSlug = "repo_slug"
        case repoURL = "repo_url"
        case slug, status, title
    }
}
