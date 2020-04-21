//
//  RawServerResponse.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

struct BuildRawServerResponse: Decodable {

    var paging: BuildPaging
    var data: [Build]

    enum CodingKeys: String, CodingKey {
        case data, paging
    }

    static func decode(data: Data) -> BuildRawServerResponse? {
        let rawResponse = try? JSONDecoder().decode(BuildRawServerResponse.self, from: data)
        return rawResponse
    }
}
