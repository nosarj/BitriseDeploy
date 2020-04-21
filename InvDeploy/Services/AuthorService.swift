//
//  AuthorService.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 20/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

enum AuthorService {
    static func configureAuthorList(builds: [Build]) -> [String] {
        var authorList = Set<String>()
        for build in builds {
            authorList.insert(build.originalBuildParams.pullRequestAuthor)
        }
        return Array(authorList).sorted()
    }
}
