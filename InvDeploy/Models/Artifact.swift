//
//  Artifact.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

struct Artifact: Decodable {
    let title, artifactType: String
    let artifactMeta: ArtifactMeta?
    let isPublicPageEnabled: Bool
    let slug: String
    let fileSizeBytes: Int

    enum CodingKeys: String, CodingKey {
        case title
        case artifactType = "artifact_type"
        case artifactMeta = "artifact_meta"
        case isPublicPageEnabled = "is_public_page_enabled"
        case slug
        case fileSizeBytes = "file_size_bytes"
    }
}
