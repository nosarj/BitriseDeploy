//
//  Paging.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct Paging: Decodable {
    let totalItemCount, pageItemLimit: Int
    let next: String?

    enum CodingKeys: String, CodingKey {
        case totalItemCount = "total_item_count"
        case pageItemLimit = "page_item_limit"
        case next
    }
}
