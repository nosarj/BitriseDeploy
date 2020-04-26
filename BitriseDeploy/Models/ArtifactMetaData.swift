//
//  ArtifactMetaData.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct ArtifactMeta: Decodable {
    let infoTypeID, fileSizeBytes: String
    let testDeviceIDList: [String]?
    let isTestInstallEnabled: Bool
    let installType: String
    let appInfo: AppInfo
    let scheme: String?

    enum CodingKeys: String, CodingKey {
        case infoTypeID = "info_type_id"
        case fileSizeBytes = "file_size_bytes"
        case testDeviceIDList = "test_device_id_list"
        case isTestInstallEnabled = "is_test_install_enabled"
        case installType = "install_type"
        case appInfo = "app_info"
        case scheme
    }
}
