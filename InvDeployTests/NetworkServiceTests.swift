//
//  InvDeployTests.swift
//  InvDeployTests
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import XCTest
@testable import InvDeploy

class NetworkServiceTests: XCTestCase {
    
    let mockURLSession = MockURLSession()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDownloadBuildList() {
        UserDefaults.standard.set("BuildListTest", forKey: "AppID")
        let buildListExpectation = expectation(description: "BuildDownload")
        NetworkService.downloadBuilds(urlSession: mockURLSession) { (result) in
            switch result {
            case .success(let data):
                guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyHashable] else {
                    XCTFail("Unable to read JSON object")
                    return
                }
                guard let data = dict["data"] as? Array<Any>, let firstBuild = data.first as? [String: AnyHashable], let slug = firstBuild["slug"] as? String else { return }
                XCTAssertTrue(slug == "6a207b1bc7a8501b")
                buildListExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                buildListExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
