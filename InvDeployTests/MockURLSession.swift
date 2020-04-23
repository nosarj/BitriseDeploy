//
//  MockURLSession.swift
//  InvDeployTests
//
//  Created by Yishai Roodyn on 23/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let urlResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        guard let url = request.url?.absoluteString else { return URLSessionDataTaskMock { completionHandler(nil, urlResponse, nil) } }
        if url.contains("BuildListTest") {
            let data = try? JSONSerialization.data(withJSONObject: mockBuldListJSON, options: .fragmentsAllowed)
            completionHandler(data, urlResponse, nil)
        }        
        return URLSessionDataTaskMock { completionHandler(nil, urlResponse, nil) }
    }
    
    
    
    let mockBuldListJSON: [String: Any] = [
        "data": [
            [
                "triggered_at": "2020-04-23T11:04:47Z",
                "started_on_worker_at": "2020-04-23T11:04:49Z",
                "environment_prepare_finished_at": "2020-04-23T11:04:49Z",
                "finished_at": "2020-04-23T11:32:39Z",
                "slug": "6a207b1bc7a8501b",
                "status": 1,
                "status_text": "success",
                "abort_reason": nil,
                "is_on_hold": false,
                "branch": "IOS-23160_Clear_Badge_5_9",
                "build_number": 915,
                "commit_hash": "6b2579d74baf2ad6ae113bfd0637f23615830641",
                "commit_message": "IOS-23160: clear app badge",
                "tag": nil,
                "triggered_workflow": "Pull Request",
                "triggered_by": "webhook",
                "machine_type_id": "elite",
                "stack_identifier": "osx-xcode-11.4.x",
                "original_build_params": [
                    "commit_hash": "6b2579d74baf2ad6ae113bfd0637f23615830641",
                    "commit_message": "IOS-23160: clear app badge",
                    "branch": "IOS-23160_Clear_Badge_5_9",
                    "branch_repo_owner": "fusionmedialimited",
                    "branch_dest": "master",
                    "branch_dest_repo_owner": "fusionmedialimited",
                    "pull_request_id": 338,
                    "pull_request_repository_url": "git@github.com:fusionmedialimited/iOSApp-New.git",
                    "pull_request_merge_branch": "pull/338/merge",
                    "pull_request_head_branch": "pull/338/head",
                    "pull_request_author": "avrahams-investing",
                    "diff_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/338.diff",
                    "commit_paths": nil,
                    "check_run_id": 611776717
                ],
                "pull_request_id": 338,
                "pull_request_target_branch": "master",
                "pull_request_view_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/338",
                "commit_view_url": "https://github.com/fusionmedialimited/iOSApp-New/commit/6b2579d74baf2ad6ae113bfd0637f23615830641"
            ],
            [
                "triggered_at": "2020-04-23T10:34:45Z",
                "started_on_worker_at": "2020-04-23T10:34:47Z",
                "environment_prepare_finished_at": "2020-04-23T10:34:47Z",
                "finished_at": "2020-04-23T11:02:26Z",
                "slug": "df9ef1a9ceb94527",
                "status": 1,
                "status_text": "success",
                "abort_reason": nil,
                "is_on_hold": false,
                "branch": "Unitests_Avi",
                "build_number": 914,
                "commit_hash": "242ea0a7206c01267df56fbd770db672b780f794",
                "commit_message": "Deeplinks unitests addition",
                "tag": nil,
                "triggered_workflow": "Pull Request",
                "triggered_by": "webhook",
                "machine_type_id": "elite",
                "stack_identifier": "osx-xcode-11.4.x",
                "original_build_params": [
                    "commit_hash": "242ea0a7206c01267df56fbd770db672b780f794",
                    "commit_message": "Deeplinks unitests addition",
                    "branch": "Unitests_Avi",
                    "branch_repo_owner": "fusionmedialimited",
                    "branch_dest": "master",
                    "branch_dest_repo_owner": "fusionmedialimited",
                    "pull_request_id": 367,
                    "pull_request_repository_url": "git@github.com:fusionmedialimited/iOSApp-New.git",
                    "pull_request_merge_branch": "pull/367/merge",
                    "pull_request_head_branch": "pull/367/head",
                    "pull_request_author": "avrahams-investing",
                    "diff_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/367.diff",
                    "commit_paths": nil,
                    "check_run_id": 611702875
                ],
                "pull_request_id": 367,
                "pull_request_target_branch": "master",
                "pull_request_view_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/367",
                "commit_view_url": "https://github.com/fusionmedialimited/iOSApp-New/commit/242ea0a7206c01267df56fbd770db672b780f794"
            ],
            [
                "triggered_at": "2020-04-23T08:16:10Z",
                "started_on_worker_at": "2020-04-23T08:16:11Z",
                "environment_prepare_finished_at": "2020-04-23T08:16:11Z",
                "finished_at": "2020-04-23T08:36:31Z",
                "slug": "94b5fa306c51f7a3",
                "status": 1,
                "status_text": "success",
                "abort_reason": nil,
                "is_on_hold": false,
                "branch": "feature/DFP-based-on-23144-23145-23252",
                "build_number": 913,
                "commit_hash": nil,
                "commit_message": nil,
                "tag": nil,
                "triggered_workflow": "QABuild",
                "triggered_by": "manual-maxro",
                "machine_type_id": "elite",
                "stack_identifier": "osx-xcode-11.4.x",
                "original_build_params": [
                    "branch": "feature/DFP-based-on-23144-23145-23252",
                    "workflow_id": "QABuild"
                ],
                "pull_request_id": 0,
                "pull_request_target_branch": nil,
                "pull_request_view_url": nil,
                "commit_view_url": nil
            ],
            [
                "triggered_at": "2020-04-23T07:03:34Z",
                "started_on_worker_at": "2020-04-23T07:03:37Z",
                "environment_prepare_finished_at": "2020-04-23T07:03:37Z",
                "finished_at": "2020-04-23T07:31:24Z",
                "slug": "371d07fd0d5bc32f",
                "status": 1,
                "status_text": "success",
                "abort_reason": nil,
                "is_on_hold": false,
                "branch": "IOS-23248_Star_Icon_Holdings_Bug_5_9",
                "build_number": 912,
                "commit_hash": "1bedff7ba2d93ab0fbac31cbef29ae6552861aa3",
                "commit_message": "IOS-23248: star icon in holdings bug fix",
                "tag": nil,
                "triggered_workflow": "Pull Request",
                "triggered_by": "webhook",
                "machine_type_id": "elite",
                "stack_identifier": "osx-xcode-11.4.x",
                "original_build_params": [
                    "commit_hash": "1bedff7ba2d93ab0fbac31cbef29ae6552861aa3",
                    "commit_message": "IOS-23248: star icon in holdings bug fix",
                    "branch": "IOS-23248_Star_Icon_Holdings_Bug_5_9",
                    "branch_repo_owner": "fusionmedialimited",
                    "branch_dest": "master",
                    "branch_dest_repo_owner": "fusionmedialimited",
                    "pull_request_id": 361,
                    "pull_request_repository_url": "git@github.com:fusionmedialimited/iOSApp-New.git",
                    "pull_request_merge_branch": "pull/361/merge",
                    "pull_request_head_branch": "pull/361/head",
                    "pull_request_author": "avrahams-investing",
                    "diff_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/361.diff",
                    "commit_paths": nil,
                    "check_run_id": 611152631
                ],
                "pull_request_id": 361,
                "pull_request_target_branch": "master",
                "pull_request_view_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/361",
                "commit_view_url": "https://github.com/fusionmedialimited/iOSApp-New/commit/1bedff7ba2d93ab0fbac31cbef29ae6552861aa3"
            ],
            [
                "triggered_at": "2020-04-23T06:46:55Z",
                "started_on_worker_at": "2020-04-23T06:46:56Z",
                "environment_prepare_finished_at": "2020-04-23T06:46:56Z",
                "finished_at": "2020-04-23T07:12:03Z",
                "slug": "8c66d54add04aff7",
                "status": 1,
                "status_text": "success",
                "abort_reason": nil,
                "is_on_hold": false,
                "branch": "IOS-23246-and-IOS-23248",
                "build_number": 911,
                "commit_hash": "645b88dc20e0f9be064bc378c313c72a98aeb35b",
                "commit_message": "master",
                "tag": nil,
                "triggered_workflow": "Pull Request",
                "triggered_by": "webhook",
                "machine_type_id": "elite",
                "stack_identifier": "osx-xcode-11.4.x",
                "original_build_params": [
                    "commit_hash": "645b88dc20e0f9be064bc378c313c72a98aeb35b",
                    "commit_message": "master",
                    "branch": "IOS-23246-and-IOS-23248",
                    "branch_repo_owner": "fusionmedialimited",
                    "branch_dest": "master",
                    "branch_dest_repo_owner": "fusionmedialimited",
                    "pull_request_id": 363,
                    "pull_request_repository_url": "git@github.com:fusionmedialimited/iOSApp-New.git",
                    "pull_request_merge_branch": "pull/363/merge",
                    "pull_request_head_branch": "pull/363/head",
                    "pull_request_author": "alina-yukon",
                    "diff_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/363.diff",
                    "commit_paths": nil,
                    "check_run_id": 611113977
                ],
                "pull_request_id": 363,
                "pull_request_target_branch": "master",
                "pull_request_view_url": "https://github.com/fusionmedialimited/iOSApp-New/pull/363",
                "commit_view_url": "https://github.com/fusionmedialimited/iOSApp-New/commit/645b88dc20e0f9be064bc378c313c72a98aeb35b"
            ]
        ],
        "paging": [
            "total_item_count": 821,
            "page_item_limit": 5,
            "next": "a08d6740dc454d90"
        ]
    ]
}
