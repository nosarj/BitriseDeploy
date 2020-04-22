//
//  Build.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

class Build: Decodable {
    let slug: String
    let buildNumber: Int
    let commitMessage: String?
    var version: String? = ""
    var app: App? = nil
    let originalBuildParams: OriginalBuildParams

    enum CodingKeys: String, CodingKey {
        case slug
        case buildNumber = "build_number"
        case commitMessage = "commit_message"
        case originalBuildParams = "original_build_params"
    }

    static func decode(data: Data) -> Build? {
        let build = try? JSONDecoder().decode(Build.self, from: data)
        return build
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
