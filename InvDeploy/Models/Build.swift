//
//  Build.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

class Build: Decodable {
//    let triggeredAt, startedOnWorkerAt, environmentPrepareFinishedAt, finishedAt,
    let slug: String
//    let status: Int
//    let statusText: StatusText
//    let abortReason: JSONNull?
//    let isOnHold: Bool
//    let branch: String
    let buildNumber: Int
//    let commitHash
    let commitMessage: String?
    var version: String? = ""
    var app: App? = nil
//    let version: String
//    let tag: JSONNull?
//    let triggeredWorkflow: TriggeredWorkflow
//    let triggeredBy: TriggeredBy
//    let machineTypeID: MachineTypeID
//    let stackIdentifier: StackIdentifier
    let originalBuildParams: OriginalBuildParams
//    let pullRequestID: Int
//    let pullRequestTargetBranch: PullRequestTargetBranch
//    let pullRequestViewURL, commitViewURL: String

    enum CodingKeys: String, CodingKey {
//        case triggeredAt = "triggered_at"
//        case startedOnWorkerAt = "started_on_worker_at"
//        case environmentPrepareFinishedAt = "environment_prepare_finished_at"
//        case finishedAt = "finished_at"
        case slug
//        status
//        case statusText = "status_text"
//        case abortReason = "abort_reason"
//        case isOnHold = "is_on_hold"
//        case branch
        case buildNumber = "build_number"
//        case commitHash = "commit_hash"
        case commitMessage = "commit_message"
//        case tag
//        case triggeredWorkflow = "triggered_workflow"
//        case triggeredBy = "triggered_by"
//        case machineTypeID = "machine_type_id"
//        case stackIdentifier = "stack_identifier"
        case originalBuildParams = "original_build_params"
//        case pullRequestID = "pull_request_id"
//        case pullRequestTargetBranch = "pull_request_target_branch"
//        case pullRequestViewURL = "pull_request_view_url"
//        case commitViewURL = "commit_view_url"
    }

//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.slug = try! container.decode(String.self, forKey: .slug)
//        self.buildNumber = try! container.decode(Int.self, forKey: .buildNumber)
//        self.commitMessage = try! container.decode(String.self, forKey: .commitMessage)
//        self.originalBuildParams = try! container.decode(OriginalBuildParams.self, forKey: .originalBuildParams)
//    }

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
