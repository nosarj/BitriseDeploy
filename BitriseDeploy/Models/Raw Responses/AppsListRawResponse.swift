//
//  AppsListRawResponse.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct AppsListRawResponse: Decodable {
    
    let data: [App]
    let paging: Paging

    static func decode(data: Data) -> AppsListRawResponse? {
        let rawResponse = try? JSONDecoder().decode(AppsListRawResponse.self, from: data)
        return rawResponse
    }
}
