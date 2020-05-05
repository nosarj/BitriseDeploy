//
//  MockAppListResponse.swift
//  BitriseDeployTests
//
//  Created by Yishai Roodyn on 05/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import Foundation

struct MockAppListResponse {
    
    static let mockAppListJSON: [String: Any] = [
        "data": [
            [
                "slug": "b35317f3dfefff3e",
                "title": "Test App 1",
                "project_type": "ios",
                "provider": "github",
                "repo_owner": "Test Repo Owener",
                "repo_url": "git@github.com:Test_Repo_Owener/Test_App_1",
                "repo_slug": "Test App 1",
                "is_disabled": false,
                "status": 1,
                "is_public": false,
                "owner": [
                    "account_type": "organization",
                    "name": "Test Owner",
                    "slug": "cf3f70acf0f5fc90"
                ],
                "avatar_url": "https://concrete-userfiles-production.s3.us-west-2.amazonaws.com/repositories/1234567/avatar/avatar.png"
            ],
            [
                "slug": "24246d583a4083a3",
                "title": "Test App 2",
                "project_type": "android",
                "provider": "github",
                "repo_owner": "Test Owner",
                "repo_url": "git@github.com:Test_Repo_Owener/Test_App_2",
                "repo_slug": "AndroidRepo",
                "is_disabled": false,
                "status": 1,
                "is_public": false,
                "owner": [
                    "account_type": "organization",
                    "name": "Test Owner",
                    "slug": "cf3f70acf0f5fc90"
                ],
                "avatar_url": "https://concrete-userfiles-production.s3.us-west-2.amazonaws.com/repositories/7654321/avatar/avatar.png"
            ],
            [
                "slug": "f3f95d514f0229b3",
                "title": "Test App 3",
                "project_type": "ios",
                "provider": "github",
                "repo_owner": "Test Owner",
                "repo_url": "git@github.com:Test_Repo_Owener/Test_App_3",
                "repo_slug": "iOSApp-New",
                "is_disabled": false,
                "status": 1,
                "is_public": false,
                "owner": [
                    "account_type": "organization",
                    "name": "Test Owner",
                    "slug": "cf3f70acf0f5fc90"
                ],
                "avatar_url": "https://concrete-userfiles-production.s3.us-west-2.amazonaws.com/repositories/7654323456543/avatar/avatar.png"
            ]
        ],
        "paging": [
            "total_item_count": 3,
            "page_item_limit": 50
        ]
    ]
}
