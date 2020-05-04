//
//  Build.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

class Build: Decodable {
    let slug: String?
    let buildNumber: Int?
    let commitMessage: String?
    var version: String? = ""
    var triggeredWorkflow: String?
    var app: AppArtifact? = nil
    let originalBuildParams: OriginalBuildParams?
    var branch: String?

    enum CodingKeys: String, CodingKey {
        case slug
        case triggeredWorkflow = "triggered_workflow"
        case buildNumber = "build_number"
        case commitMessage = "commit_message"
        case originalBuildParams = "original_build_params"
        case branch
    }

    static func decode(data: Data) -> Build? {
        let build = try? JSONDecoder().decode(Build.self, from: data)
        return build
    }
    
    init(slug: String?, buildNumber: Int?, commitMessage: String?, originalBuildParams: OriginalBuildParams?, branch: String?) {
        self.slug = slug
        self.buildNumber = buildNumber
        self.commitMessage = commitMessage
        self.originalBuildParams = originalBuildParams
        self.branch = branch
    }
}

extension Build: Equatable {
    static func == (lhs: Build, rhs: Build) -> Bool {
        if lhs.slug == rhs.slug {
            return true
        }
        return false
    }
}
