//
//  AuthorService.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 20/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

enum AuthorService {
    static func configureAuthorList(builds: [Build]) -> [String] {
        var authorList = Set<String>()
        for build in builds {
            if let author = build.originalBuildParams.pullRequestAuthor {
                authorList.insert(author)
            }
        }
        return Array(authorList).sorted()
    }
}
