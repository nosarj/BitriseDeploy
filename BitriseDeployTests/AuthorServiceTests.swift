//
//  AuthorServiceTests.swift
//  BitriseDeployTests
//
//  Created by Yishai Roodyn on 27/04/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import XCTest
@testable import Bitrise_Deploy

class AuthorServiceTests: XCTestCase {
    
    var build1: Build?
    var build2: Build?
    var build3: Build?
    var build4: Build?
    var build5: Build?
    
    override func setUpWithError() throws {
        createBuilds()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func createBuilds() {
        build1 = Build(slug: "12345", buildNumber: 1, commitMessage: "TEST", originalBuildParams: createOriginalBuildParams(), branch: "master")
        build2 = Build(slug: "12345", buildNumber: 1, commitMessage: "TEST", originalBuildParams: createOriginalBuildParams(), branch: "master")
        build3 = Build(slug: "12345", buildNumber: 1, commitMessage: "TEST", originalBuildParams: createOriginalBuildParams(), branch: "master")
        build4 = Build(slug: "12345", buildNumber: 1, commitMessage: "TEST", originalBuildParams: createOriginalBuildParams(author: "Boris"), branch: "master")
        build5 = Build(slug: "12345", buildNumber: 1, commitMessage: "TEST", originalBuildParams: createOriginalBuildParams(author: "Macron"), branch: "master")
    }
    
    func createOriginalBuildParams(author: String = "Donald Trump") -> OriginalBuildParams {
        let originalBuildParams = OriginalBuildParams(commitHash: nil, commitMessage: nil, branch: nil, pullRequestID: nil, pullRequestMergeBranch: nil, pullRequestHeadBranch: nil, pullRequestAuthor: author, diffURL: nil, checkRunID: nil)
        return originalBuildParams
    }
    
    func testcConfigureAuthorList() {
        let buildArray = [build1, build2, build3, build4, build5].compactMap( { $0 })
        let authorList = AuthorService.configureAuthorList(builds: buildArray)
        XCTAssertEqual(authorList.count, 3)
        XCTAssertEqual(authorList.first, "Boris")
    }

}
