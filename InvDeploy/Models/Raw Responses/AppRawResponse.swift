//
//  AppRawResponse.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

struct AppRawResponse: Decodable {
    
    let data: App

    static func decode(data: Data) -> AppRawResponse? {
        let rawResponse = try? JSONDecoder().decode(AppRawResponse.self, from: data)
        return rawResponse
    }
}
