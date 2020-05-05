//
//  MockURLSession.swift
//  BitriseDeployTests
//
//  Created by Yishai Roodyn on 23/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    
    override init() { }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let urlResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        guard let url = request.url?.absoluteString else { return URLSessionDataTaskMock { completionHandler(nil, urlResponse, nil) } }
        if url.contains("BuildListTest") {
            let data = try? JSONSerialization.data(withJSONObject: MockBuildListResponse.mockBuldListJSON, options: .fragmentsAllowed)
            completionHandler(data, urlResponse, nil)
        } else if url.contains("ArtifactListTest") {
            let data = try? JSONSerialization.data(withJSONObject: MockArtifactListResponse.mockArtifactListJSON, options: .fragmentsAllowed)
            completionHandler(data, urlResponse, nil)
        } else if url.contains("ArtifactTest") {
            let data = try? JSONSerialization.data(withJSONObject: MockArtifactResponse.mockArtifactResponse, options: .fragmentsAllowed)
            completionHandler(data, urlResponse, nil)
        } else if url.contains("WorkflowTest") {
            let data = try? JSONSerialization.data(withJSONObject: MockWorkflowResponse.mockWorkflowResponse, options: .fragmentsAllowed)
            completionHandler(data, urlResponse, nil)
        } else {
            let data = try? JSONSerialization.data(withJSONObject: MockAppListResponse.mockAppListJSON, options: .fragmentsAllowed)
            completionHandler(data, urlResponse, nil)
        }
        return URLSessionDataTaskMock { completionHandler(nil, urlResponse, nil) }
    }
}
