//
//  ArtefactRawServerResponse.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct ArtifactRawServerResponse: Decodable {
    let data: [Artifact]
    let paging: ArtifactPaging

    enum CodingKeys: String, CodingKey {
        case data, paging
    }

    static func decode(data: Data) -> ArtifactRawServerResponse? {
        let rawResponse = try? JSONDecoder().decode(ArtifactRawServerResponse.self, from: data)
        return rawResponse
    }
}
