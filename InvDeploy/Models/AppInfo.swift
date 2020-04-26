//
//  AppInfo.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct AppInfo: Codable {
    let appTitle, bundleID, version, buildNumber: String
    let minOSVersion: String
    let deviceFamilyList: [Int]

    enum CodingKeys: String, CodingKey {
        case appTitle = "app_title"
        case bundleID = "bundle_id"
        case version
        case buildNumber = "build_number"
        case minOSVersion = "min_OS_version"
        case deviceFamilyList = "device_family_list"
    }
}
