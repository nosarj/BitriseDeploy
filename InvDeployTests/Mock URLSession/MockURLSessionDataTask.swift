//
//  MockURLSessionDataTask.swift
//  InvDeployTests
//
//  Created by Yishai Roodyn on 23/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}
