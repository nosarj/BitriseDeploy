//
//  BitriseDeployTests.swift
//  BitriseDeployTests
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import XCTest
@testable import Bitrise_Deploy

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
                XCTAssertEqual(slug, "6a207b1bc7a8501b")
                buildListExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                buildListExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadArtifactList() {
        UserDefaults.standard.set("ArtifactListTest", forKey: "AppID")
        let buildListExpectation = expectation(description: "BuildDownload")
        NetworkService.downloadArtifactList(urlSession: mockURLSession, buildSlug: "6a207b1bc7a8501b") { (result) in
            switch result {
            case .success(let data):
                guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyHashable] else {
                    XCTFail("Unable to read JSON object")
                    return
                }
                guard let data = dict["data"] as? Array<Any>, let firstArtifact = data.first as? [String: AnyHashable], let slug = firstArtifact["slug"] as? String else { return }
                XCTAssertEqual(slug, "18cc490b67a15058")
                buildListExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                buildListExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadArtifact() {
        UserDefaults.standard.set("ArtifactTest", forKey: "AppID")
        let buildListExpectation = expectation(description: "BuildDownload")
        NetworkService.downloadArtifact(urlSession: mockURLSession, buildSlug: "6a207b1bc7a8501b", artifactSlug: "0a75ce3ba7d97a2d") { (result) in
            switch result {
            case .success(let data):
                guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyHashable] else {
                    XCTFail("Unable to read JSON object")
                    return
                }
                guard let data = dict["data"] as? [String: Any], let slug = data["slug"] as? String else { return }
                XCTAssertEqual(slug, "0a75ce3ba7d97a2d")
                buildListExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                buildListExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadWorkflows() {
        UserDefaults.standard.set("WorkflowTest", forKey: "AppID")
        let buildListExpectation = expectation(description: "BuildDownload")
        NetworkService.downloadWorkflows(urlSession: mockURLSession) { (result) in
            switch result {
            case .success(let data):
                guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyHashable] else {
                    XCTFail("Unable to read JSON object")
                    return
                }
                guard let data = dict["data"] as? [String] else { return }
                XCTAssertEqual(data.count, 14)
                XCTAssertEqual(data.first, "Pull Request")
                buildListExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                buildListExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
