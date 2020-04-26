//
//  App.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct App: Decodable {
    let title, artifactType: String
    let expiringDownloadURL: String
    let isPublicPageEnabled: Bool
    let slug: String
    let publicInstallPageURL: String
    let fileSizeBytes: Int

    enum CodingKeys: String, CodingKey {
        case title
        case artifactType = "artifact_type"
        case expiringDownloadURL = "expiring_download_url"
        case isPublicPageEnabled = "is_public_page_enabled"
        case slug
        case publicInstallPageURL = "public_install_page_url"
        case fileSizeBytes = "file_size_bytes"
    }
}
