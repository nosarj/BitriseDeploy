//
//  WorkflowList.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 21/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct WorkflowList: Decodable {

    var data: [String]

    enum CodingKeys: String, CodingKey {
        case data
    }

    static func decode(data: Data) -> WorkflowList? {
        let rawResponse = try? JSONDecoder().decode(WorkflowList.self, from: data)
        return rawResponse
    }
}
