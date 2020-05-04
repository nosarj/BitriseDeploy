//
//  AppArtifactRawResponse.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 03/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import Foundation

struct AppArtifactRawResponse: Decodable {
    
    let data: AppArtifact

    static func decode(data: Data) -> AppArtifactRawResponse? {
        let rawResponse = try? JSONDecoder().decode(AppArtifactRawResponse.self, from: data)
        return rawResponse
    }
}
