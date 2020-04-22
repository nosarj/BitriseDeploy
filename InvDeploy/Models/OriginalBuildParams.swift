//
//  OriginalBuildParams.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

struct OriginalBuildParams: Decodable {
    
    let commitHash: String?
    let commitMessage: String?
    let branch: String?
    let pullRequestID: Int?
    let pullRequestMergeBranch, pullRequestHeadBranch, pullRequestAuthor: String?
    let diffURL: String?
    let checkRunID: Int?

    enum CodingKeys: String, CodingKey {
        case commitHash = "commit_hash"
        case commitMessage = "commit_message"
        case branch
        case pullRequestID = "pull_request_id"
        case pullRequestMergeBranch = "pull_request_merge_branch"
        case pullRequestHeadBranch = "pull_request_head_branch"
        case pullRequestAuthor = "pull_request_author"
        case diffURL = "diff_url"
        case checkRunID = "check_run_id"
    }
}
